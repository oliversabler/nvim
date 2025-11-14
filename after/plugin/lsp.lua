local lsp = require "lsp-zero".preset({})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })

    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover({
            border = "single"
        })
    end, opts)

    -- Format on save
    -- if client.server_capabilities.documentFormattingProvider then
    --     vim.api.nvim_create_autocmd("BufWritePre", {
    --         buffer = bufnr,
    --         callback = function()
    --             vim.lsp.buf.format({ async = false })
    --         end,
    --     })
    -- end
end)

lsp.setup()

local cmp = require "cmp"
local cmp_action = require "lsp-zero".cmp_action()

cmp.setup({
    mapping = {
        ["<CR>"] = cmp.mapping.confirm({ select = false }),

        ["<C-Space>"] = cmp.mapping.complete(),

        ["<C-f>"] = cmp_action.luasnip_jump_forward(),
        ["<C-b>"] = cmp_action.luasnip_jump_backward(),
    }
})

require "mason".setup()

vim.lsp.config("clangd", {
    filetypes = { "c" },
    -- cmd = { "clangd", "--fallback-style=Google" },
})
vim.lsp.enable("clangd");

vim.lsp.config("omnisharp", {
    cmd = {
        "dotnet",
        vim.fn.expand("~/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll")
    },

    settings = {
        FormattingOptions = {
            EnableEditorConfigSupport = true,
        },
        RoslynExtensionsOptions = {
            AnalyzeOpenDocumentsOnly = true,
        }
    }
})
vim.lsp.enable("omnisharp")

vim.lsp.config("gopls", {})
vim.lsp.enable("gopls")

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        }
    }
})
vim.lsp.enable("lua_ls")

vim.lsp.config("ruff", {})
vim.lsp.enable("ruff")

vim.lsp.config("rust_analyzer", {})
vim.lsp.enable("rust_analyzer")

vim.lsp.config("ts_ls", {})
vim.lsp.enable("ts_ls")
