# NVIM

## Install
1. Clone to ~/.config/
2. Run nvim?

### Prerequisites
- Telescope: [ripgrep](https://github.com/BurntSushi/ripgrep)
- nvim-treesitter needs tree-sitter-cli, install with brew or something
- Go debugging: [delve](https://github.com/go-delve/delve)
- .NET debugging (see section below)

## Plugins
* [Telescope](https://github.com/nvim-telescope/telescope.nvim)
* [LSP-Zero](https://github.com/VonHeikemen/lsp-zero.nvim)
* [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
* [Oil](https://github.com/stevearc/oil.nvim)
* [DAP](https://github.com/mfussenegger/nvim-dap)

## .NET debugging

1. Install the [.NET SDK](https://dotnet.microsoft.com/download).
2. Download the latest macOS ARM64 netcoredbg from [Samsung's releases](https://github.com/Samsung/netcoredbg/releases).
3. Extract the entire netcoredbg folder to `~/.local/share/netcoredbg/VERSION/` (replace `VERSION` with the release version).
4. Link it: `ln -sfn VERSION ~/.local/share/netcoredbg/current`.
5. Make it executable: `chmod u+x ~/.local/share/netcoredbg/current/netcoredbg`.
6. Optional: [easy-dotnet.nvim](https://github.com/GustavEikaas/easy-dotnet.nvim): `dotnet tool install -g EasyDotnet`.

## Commands Cheat Sheet

| Command       | Mode   | Comment                            |
|---------------|--------|------------------------------------|
| space + pv    | Normal | Back to explorer                   |
| space + ff    | Normal | File files                         |
| space + gf    | Normal | Git files                          |
| space + lg    | Normal | Live grep                          |
| gd            | Normal | Go to definition                   |
| K             | Normal | Hover                              |
| space + d     | Normal | Open diagnostic window             |
| space + y     | Visual | Yank to clipboard                  |
| space + Y     | Normal | Yank line to clipboard             |
| ctrl + k      | Visual | Move line up                       |
| ctrl + j      | Visual | Move line down                     |
| space + a     | Normal | Pin current buffer to a free slot  |
| space + s     | Normal | Unpin current buffer               |
| space + w     | Normal | Toggle buffer slot visibility      |
| space + 1-5   | Normal | Go to buffer slot 1 through 5      |
| F5            | Normal | Start/continue debugging           |
| space + dl    | Normal | .NET: select project/profile       |
| space + dd    | Normal | .NET: debug default project        |
