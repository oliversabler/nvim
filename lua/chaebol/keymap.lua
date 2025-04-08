-- Toggle wrapping
local term_width = vim.opt.columns
local toggle_wrapping = false
vim.keymap.set('n', '<C-m>', function ()
    if toggle_wrapping then
        vim.opt.columns = term_width
        vim.opt.wrap=false
        vim.opt.linebreak=false

        vim.cmd('redraw')
        vim.opt.colorcolumn =  '100'
    else
        vim.opt.columns= 102
        vim.opt.colorcolumn = {}
        vim.opt.wrap=true
        vim.opt.linebreak=true
    end

    toggle_wrapping = not toggle_wrapping
end)

-- Move line(s) up/down
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv")

-- Copy to clipboard
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')
