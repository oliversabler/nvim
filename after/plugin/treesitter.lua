require "treesitter-context".setup {}

local filetypes = {
    "c",
    "go",
    "lua",
    "python",
    "vim",
    "vimdoc",
    "query",
    "markdown",
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = filetypes,
    callback = function()
        vim.treesitter.start()
    end,
})
