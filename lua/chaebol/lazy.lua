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
    -- Themes
    {
        "catppuccin/nvim",
        as = "catppuccin",
        priority = 1000
    },
    {
        "rose-pine/neovim",
        as = "rosepine"
    },
    {
        "shaunsingh/nord.nvim",
        as = "nord"
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
        dependencies = { "nvim-lua/plenary.nvim" }
    },

    -- Diffview
    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" }
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate"
    },

    -- Treesitter Context
    { "nvim-treesitter/nvim-treesitter-context" },

    -- Debug Adapter Protocol
    { "mfussenegger/nvim-dap" },
    { "leoluz/nvim-dap-go" },

    -- .NET project and launch-profile debugging
    {
        "GustavEikaas/easy-dotnet.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap" },
        opts = {
            picker = "telescope",
            lsp = { enabled = false },
            projx_lsp = { enabled = false },
            debugger = {
                bin_path = vim.fn.expand("~/.local/share/netcoredbg/current/netcoredbg"),
            },
            test_runner = { auto_start_testrunner = false },
            auto_bootstrap_namespace = { enabled = false },
            csproj_mappings = false,
            fsproj_mappings = false,
        },
    },

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
})
