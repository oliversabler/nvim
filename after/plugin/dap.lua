require'dap-go'.setup{
  delve = {
    path = vim.fn.expand('$HOME') .. '/go/bin/dlv',
  }
}
