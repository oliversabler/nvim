vim.opt.guicursor = ""

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.statuscolumn = "%!v:lua.require'chaebol.statuscolumn'.Set()"

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
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "100"

vim.opt.list = true

local space = "·"
vim.opt.listchars:append {
    tab = "» ",
    multispace = space,
    lead = space,
    trail = space,
    nbsp = space
}

vim.api.nvim_set_hl(0, "Whitespace", { fg = "#404040" })
