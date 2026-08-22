require "oil".setup({
    cleanup_delay_ms = false,
    view_options = {
        show_hidden = true
    },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
