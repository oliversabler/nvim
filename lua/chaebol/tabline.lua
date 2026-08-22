local max_slots = 5
local slots = {}
local startup_directory = vim.fn.fnamemodify(vim.fn.getcwd(), ":p"):gsub("/+$", "")
local startup_parent = vim.fn.fnamemodify(startup_directory, ":h")

local function warn(message)
    vim.notify(message, vim.log.levels.WARN, { title = "Buffer slots" })
end

local function redraw()
    vim.cmd "redrawtabline"
end

local function compact_slots(excluded_buffer)
    local compacted = {}

    for number = 1, max_slots do
        local buffer = slots[number]
        if buffer and buffer ~= excluded_buffer and vim.api.nvim_buf_is_valid(buffer) then
            compacted[#compacted + 1] = buffer
        end
    end

    slots = compacted
end

local function display_path(path)
    path = path:gsub("/+$", "")
    if path == startup_directory or path:sub(1, #startup_directory + 1) == startup_directory .. "/" then
        return path:sub(#startup_parent + 2)
    end

    return vim.fn.fnamemodify(path, ":t")
end

local function get_name(buffer)
    if vim.bo[buffer].filetype == "oil" then
        local directory = require("oil").get_current_dir(buffer)
        if directory then
            local name = display_path(directory)
            return name == "" and "/" or name .. "/"
        end
    end

    local name = display_path(vim.api.nvim_buf_get_name(buffer))
    return name == "" and "[No Name]" or name
end

local function slotline()
    local current_buffer = vim.api.nvim_get_current_buf()
    local labels = {}

    compact_slots()

    for number = 1, max_slots do
        local buffer = slots[number]
        local highlight = buffer == current_buffer and "%#TabLineSel#" or "%#TabLine#"
        local name = buffer and get_name(buffer):gsub("%%", "%%%%") or " "
        labels[number] = highlight .. "[" .. number .. "] " .. name .. " "
    end

    return table.concat(labels) .. "%#TabLineFill#"
end

local function pin()
    local buffer = vim.api.nvim_get_current_buf()
    local is_oil = vim.bo[buffer].filetype == "oil"

    if not is_oil and (vim.bo[buffer].buftype ~= "" or vim.api.nvim_buf_get_name(buffer) == "") then
        warn "Only file and Oil buffers can be pinned"
        return
    end

    compact_slots()

    for number = 1, max_slots do
        if slots[number] == buffer then
            warn("Current buffer is already pinned to slot " .. number)
            return
        end
    end

    if #slots < max_slots then
        slots[#slots + 1] = buffer
        redraw()
        return
    end

    warn("Cannot pin more than " .. max_slots .. " buffers")
end

local function unpin()
    local buffer = vim.api.nvim_get_current_buf()

    compact_slots()

    for number = 1, max_slots do
        if slots[number] == buffer then
            table.remove(slots, number)
            redraw()
            return
        end
    end

    warn "Current buffer is not pinned"
end

local function toggle()
    vim.o.showtabline = vim.o.showtabline == 0 and 2 or 0
end

local function goto_slot(number)
    number = tonumber(number)
    compact_slots()
    local buffer = number and slots[number]

    if not buffer then
        warn("No buffer pinned to slot " .. tostring(number))
        redraw()
        return
    end

    vim.api.nvim_set_current_buf(buffer)
end

vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
    callback = function(args)
        for number = 1, max_slots do
            if slots[number] == args.buf then
                local buffer = args.buf
                vim.schedule(function()
                    if not vim.api.nvim_buf_is_loaded(buffer) then
                        compact_slots(buffer)
                    end
                    redraw()
                end)
                return
            end
        end
    end,
})

vim.api.nvim_create_user_command("BufferPin", pin, { desc = "Pin current buffer to the first free slot" })
vim.api.nvim_create_user_command("BufferUnpin", unpin, { desc = "Unpin current buffer" })
vim.api.nvim_create_user_command("BufferSlotsToggle", toggle, { desc = "Toggle buffer slot visibility" })
vim.api.nvim_create_user_command("BufferGoto", function(opts)
    goto_slot(opts.args)
end, { nargs = 1, desc = "Go to buffer slot 1-5" })

vim.keymap.set("n", "<leader>a", pin, { desc = "Pin current buffer", silent = true })
vim.keymap.set("n", "<leader>s", unpin, { desc = "Unpin current buffer", silent = true })
vim.keymap.set("n", "<leader>w", toggle, { desc = "Toggle buffer slots", silent = true })

for number = 1, max_slots do
    vim.keymap.set("n", "<leader>" .. number, function()
        goto_slot(number)
    end, { desc = "Go to buffer slot " .. number, silent = true })
end

vim.o.showtabline = 0
vim.o.tabline = "%!v:lua.require'chaebol.tabline'.slotline()"

return { slotline = slotline }
