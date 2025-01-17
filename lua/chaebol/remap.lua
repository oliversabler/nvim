vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Move line(s) up/down
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv")

-- Copy to clipboard
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

-- Oil
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
