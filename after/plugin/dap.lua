require "dap-go".setup {
    delve = {
        path = vim.fn.expand("$HOME") .. "/go/bin/dlv",
    }
}

require "dapui".setup({
    layouts = {
        {
            elements = {
                { id = "scopes", size = 0.50 },
                { id = "stacks", size = 0.50 },
            },
            size = 10,
            position = "bottom"
        }
    }
})

local dap = require "dap"

-- LLDB
dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = vim.fn.expand("$HOME") .. "/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
    options = {
        env = {
            MIDebuggerPath = "/usr/bin/lldb"
        }
    }
}

dap.configurations.cpp = {
    {
        name = "Launch",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = true,
        MIMode = "lldb",
        MIDebuggerPath = '/usr/bin/lldb',
    }
}

dap.configurations.c = dap.configurations.cpp


-- UI ATTACH
local dapui = require "dapui"
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

-- KEYMAPS
vim.keymap.set("n", "<F5>", function() require("dap").continue() end)
vim.keymap.set("n", "<F10>", function() require("dap").step_over() end)
vim.keymap.set("n", "<F11>", function() require("dap").step_into() end)
vim.keymap.set("n", "<F12>", function() require("dap").step_out() end)

vim.keymap.set("n", "<Leader>b", function() require("dap").toggle_breakpoint() end)
vim.keymap.set("n", "<Leader>dr", function() require("dap").repl.open() end)

vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
    require("dap.ui.widgets").hover()
end)

vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
    require("dap.ui.widgets").preview()
end)

vim.keymap.set("n", "<Leader>df", function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.frames)
end)

vim.keymap.set("n", "<Leader>ds", function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.scopes)
end)
