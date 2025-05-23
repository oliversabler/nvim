local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    }
end

vim.opt.rtp:prepend(lazypath)

require "lazy".setup({
    -- Theme
    {
        "rose-pine/neovim",
        as = "rose-pine"
    },

    -- Oil
    {
        "stevearc/oil.nvim",
        opts = {},
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
    },

    -- Plenary
    { "nvim-lua/plenary.nvim" },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" }
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"
    },

    -- Treesitter Context
    { "nvim-treesitter/nvim-treesitter-context" },

    -- Debug Adapter Protocol
    { "mfussenegger/nvim-dap" },
    { "leoluz/nvim-dap-go" },

    -- Debug Adapter Protocol UI
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
    },

    -- Mason
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },

    -- Lsp Zero
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x"
    },
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/nvim-cmp" },
    { "L3MON4D3/LuaSnip" },

    -- Formatter
    { "sbdchd/neoformat" }
})
