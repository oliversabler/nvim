local max_slots = 5
local slots = {}
local startup_directory = vim.fn.argv(0):gsub("^oil://", "")
if vim.fn.isdirectory(startup_directory) == 0 then
    startup_directory = vim.fn.getcwd()
end
startup_directory = vim.fn.fnamemodify(startup_directory, ":p"):gsub("/+$", "")
local startup_parent = vim.fn.fnamemodify(startup_directory, ":h")
local state_directory = vim.fn.stdpath "state" .. "/buffer-slots"
local state_file = state_directory .. "/" .. vim.fn.sha256(startup_directory) .. ".json"

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
        if #slots == 1 and vim.o.showtabline == 0 then
            vim.o.showtabline = 2
        end
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

local function save_state()
    compact_slots()
    local buffers = {}
    for _, buffer in ipairs(slots) do
        buffers[#buffers + 1] = vim.api.nvim_buf_get_name(buffer)
    end

    vim.fn.mkdir(state_directory, "p")
    vim.fn.writefile({ vim.json.encode({ buffers = buffers, visible = vim.o.showtabline ~= 0 }) }, state_file)
end

local function restore_state()
    if vim.fn.filereadable(state_file) == 0 then
        return
    end

    local ok, state = pcall(vim.json.decode, table.concat(vim.fn.readfile(state_file), "\n"))
    if not ok or type(state) ~= "table" or type(state.buffers) ~= "table" then
        return
    end

    for _, name in ipairs(state.buffers) do
        if #slots == max_slots then
            break
        end
        if type(name) == "string"
            and (vim.fn.filereadable(name) == 1 or vim.fn.isdirectory((name:gsub("^oil://", ""))) == 1) then
            local buffer = vim.fn.bufadd(name)
            vim.fn.bufload(buffer)
            if vim.bo[buffer].buftype == "" then
                vim.bo[buffer].buflisted = true
            end
            slots[#slots + 1] = buffer
        end
    end

    vim.o.showtabline = state.visible and 2 or 0
    redraw()
end

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    nested = true,
    callback = function()
        restore_state()
        vim.api.nvim_create_autocmd("VimLeavePre", { callback = save_state })
    end,
})

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
