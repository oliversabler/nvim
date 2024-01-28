local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})

    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
end)

lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({select = false}),

        ['<C-Space>'] = cmp.mapping.complete(),

        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    }
})

require('mason').setup()

require('lspconfig').rust_analyzer.setup({})
require('lspconfig').gopls.setup{}
require('lspconfig').ruff_lsp.setup{}
require('lspconfig').tsserver.setup{}
require('lspconfig').lua_ls.setup{}
require('lspconfig').clangd.setup{}
