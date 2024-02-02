local format_group = vim.api.nvim_create_augroup('chaebol_format', { clear = true })

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
    group = format_group,
    pattern = '*',
    command = [[%s/\s\+$//e]],
})

-- Format go-files  on save
vim.api.nvim_create_autocmd('BufWritePre', {
    group = format_group,
    pattern = '*.go',
    callback = function()
        vim.lsp.buf.format({ async = false })
    end
})
