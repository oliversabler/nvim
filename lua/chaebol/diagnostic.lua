vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "▲",
            [vim.diagnostic.severity.HINT] = "⚑",
            [vim.diagnostic.severity.INFO] = "»",
        },
    },
    virtual_text = false,
})

vim.keymap.set("n", "<C-i>", function()
    vim.diagnostic.open_float({
        border = "single"
    })
end)
