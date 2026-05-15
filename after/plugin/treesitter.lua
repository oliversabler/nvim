require "treesitter-context".setup {}

local treesitter = require("nvim-treesitter")

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

treesitter.install(filetypes)

vim.api.nvim_create_autocmd("FileType", {
    pattern = filetypes,
    callback = function()
        vim.treesitter.start()
    end,
})
