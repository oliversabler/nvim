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

require "mason".setup({
    registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
    },
})

vim.lsp.config("clangd", {
    filetypes = { "c" },
})
vim.lsp.enable("clangd");

vim.lsp.config("roslyn", {
    settings = {
        ["csharp|background_analysis"] = {
            dotnet_analyzer_diagnostics_scope = "openFiles",
            dotnet_compiler_diagnostics_scope = "openFiles",
        },
    }
})
vim.lsp.enable("roslyn")

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

vim.lsp.config("ts_ls", {})
vim.lsp.enable("ts_ls")
