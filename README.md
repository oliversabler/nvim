# NVIM

## Install
1. Clone to ~/.config/
2. Run nvim?

### Prerequisites
For Telescopes grep_string to work, install [ripgrep](https://github.com/BurntSushi/ripgrep)

For Go debugging [delve](https://github.com/go-delve/delve) is needed

## Plugins
* [Telescope](https://github.com/nvim-telescope/telescope.nvim)
* [LSP-Zero](https://github.com/VonHeikemen/lsp-zero.nvim)
* [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
* [Oil](https://github.com/stevearc/oil.nvim)
* [DAP](https://github.com/mfussenegger/nvim-dap)

## Commands Cheat Sheet

### General
| Command     | Mode   | Comment                 |
|-------------|--------|-------------------------|
| space + pv  | Normal | Back to explorer        |
| space + ff  | Normal | File files              |
| space + gf  | Normal | Git files               |
| space + lg  | Normal | Live grep               |
| gd          | Normal | Go to definition        |
| K           | Normal | Hover                   |
| space + d   | Normal | Open diagnostic window  |
| space + y   | Visual | Yank to clipboard       |
| space + Y   | Normal | Yank line to clipboard  |
| ctrl + k    | Visual | Move line up            |
| ctrl + j    | Visual | Move line down          |

