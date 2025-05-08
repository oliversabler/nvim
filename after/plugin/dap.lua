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

dap.configurations.c = {
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

-- DOTNET
dap.adapters.coreclr = {
    type = "executable",
    command = "/usr/local/netcoredbg",
    args = { "--interpreter=vscode" }
}

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "Launch",
        request = "launch",
        program = function()
            return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
        end
    }
}

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
vim.keymap.set("n", "<F5>", function() dap.continue() end)
vim.keymap.set("n", "<F10>", function() dap.step_over() end)
vim.keymap.set("n", "<F11>", function() dap.step_into() end)
vim.keymap.set("n", "<F12>", function() dap.step_out() end)

vim.keymap.set("n", "<Leader>q", function()
    dap.terminate()
    dap.close()
    dapui.close()
end)

vim.keymap.set("n", "<Leader>b", function() dap.toggle_breakpoint() end)
vim.keymap.set("n", "<Leader>dr", function() dap.repl.open() end)

local widgets = require "dap.ui.widgets"
vim.keymap.set({ "n", "v" }, "<Leader>dh", function() widgets.hover() end)
vim.keymap.set({ "n", "v" }, "<Leader>dp", function() widgets.preview() end)
vim.keymap.set("n", "<Leader>df", function() widgets.centered_float(widgets.frames) end)
vim.keymap.set("n", "<Leader>ds", function() widgets.centered_float(widgets.scopes) end)
