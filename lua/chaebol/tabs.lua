local M = {}

local max_tabs = 5
local visible_showtabline

local function warn(message)
    vim.notify(message, vim.log.levels.WARN, { title = "Tabs" })
end

function M.create()
    local buffer = vim.api.nvim_get_current_buf()

    if vim.bo[buffer].buftype ~= "" then
        warn "Cannot create a tab for a special buffer"
        return
    end

    local current_tab = vim.api.nvim_get_current_tabpage()
    for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
        if tab ~= current_tab then
            for _, window in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
                if vim.api.nvim_win_get_buf(window) == buffer then
                    warn "A tab for this buffer already exists"
                    return
                end
            end
        end
    end

    if #vim.api.nvim_list_tabpages() >= max_tabs then
        warn("Cannot create more than " .. max_tabs .. " tabs")
        return
    end

    vim.cmd "tab split"
end

function M.close()
    if #vim.api.nvim_list_tabpages() == 1 then
        warn "Cannot close the only tab"
        return
    end

    vim.cmd "tabclose"
end

function M.toggle()
    if vim.o.showtabline == 0 then
        vim.o.showtabline = visible_showtabline or 1
        visible_showtabline = nil
    else
        visible_showtabline = vim.o.showtabline
        vim.o.showtabline = 0
    end
end

function M.goto_tab(number)
    number = tonumber(number)
    if number and number >= 1 and number <= max_tabs and vim.api.nvim_list_tabpages()[number] then
        vim.cmd.tabnext(number)
    end
end

vim.api.nvim_create_user_command("TabCreate", M.create, { desc = "Open current buffer in a new tab" })
vim.api.nvim_create_user_command("TabClose", M.close, { desc = "Close current tab" })
vim.api.nvim_create_user_command("TabToggle", M.toggle, { desc = "Toggle tabline visibility" })
vim.api.nvim_create_user_command("TabGoto", function(opts)
    M.goto_tab(opts.args)
end, { nargs = 1, desc = "Go to tab 1-5" })

vim.keymap.set("n", "<leader>a", M.create, { desc = "Open current buffer in a new tab", silent = true })
vim.keymap.set("n", "<leader>s", M.close, { desc = "Close current tab", silent = true })
vim.keymap.set("n", "<leader>w", M.toggle, { desc = "Toggle tabline visibility", silent = true })

for number = 1, max_tabs do
    vim.keymap.set("n", "<leader>" .. number, function()
        M.goto_tab(number)
    end, { desc = "Go to tab " .. number, silent = true })
end

return M
