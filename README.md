# NVIM

## Install
1. Install (clone) at ~/.config/
2. Install packer (https://github.com/wbthomason/packer.nvim)
3. Comment out theme lines in lua/chaebol/packer.lua
4. :so
5. :PackerInstall
6. Fix theme and run :PackerInstall again

### Prerequisites
For Telescopes grep_string to work, install [ripgrep](https://github.com/BurntSushi/ripgrep)

## Plugins
* [Telescope](https://github.com/nvim-telescope/telescope.nvim)
* [Zero-LSP](https://github.com/VonHeikemen/lsp-zero.nvim)
* [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
* [Harpoon](https://github.com/ThePrimeagen/harpoon)
* [Undotree](https://github.com/mbbill/undotree)

## Commands Cheat Sheet

### General
| Command   | Mode   | Comment          |
|-----------|--------|------------------|
| space+pv  | Normal | Back to explorer |
| space+ps  | Normal | Search           |
| space+pf  | Normal | File search      |
| space+u   | Normal | Undotree         |
| gd        | Normal | Go to definition |
| K         | Normal | Hover            |

### Harpoon
| Command  | Mode   | Comment         |
|----------|--------|-----------------|
| space+a  | Normal | Add file        |
| ctrl + e | Normal | Menu            |
| ctrl + 1 | Normal | Swap to file #1 |
| ctrl + 2 | Normal | Swap to file #2 |
| ctrl + 3 | Normal | Swap to file #3 |
| ctrl + 4 | Normal | Swap to file #4 |

https://www.tablesgenerator.com/markdown_tables

## What's missing
* Auto 'import' (rust, python)
* Format on save (cargo fmt)
* Do I need Undotree?
