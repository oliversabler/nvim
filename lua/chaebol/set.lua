vim.opt.guicursor = ''

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.statuscolumn = [[%!v:lua.StatusColumn()]]

function StatusColumn()
  local rel_num = vim.v.relnum
  local abs_num = vim.v.lnum
  local sign = vim.fn.sign_getplaced(vim.api.nvim_get_current_buf(), {
    lnum = abs_num,
    group = '*'
  })[1].signs

  local sign_col= " "
  if sign and #sign > 0 then
    local name = sign[1].name
    if name:match("DapBreakpoint") then
      sign_col = "●"
    else
      sign_col = " "
    end
  end

  local rel_str = string.format('%3d', rel_num)
  local abs_str = string.format('%3d', abs_num)

  return string.format('%s%s %s ', abs_str, rel_str, sign_col)
end

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.ignorecase = true

vim.opt.wrap = false
vim.opt.splitright = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

vim.opt.updatetime = 50

vim.opt.colorcolumn = '100'

vim.opt.list = true

local space = '·'
vim.opt.listchars:append {
    tab = '» ',
    multispace = space,
    lead = space,
    trail = space,
    nbsp = space
}

vim.api.nvim_set_hl(0, 'Whitespace', { fg = '#404040' })
