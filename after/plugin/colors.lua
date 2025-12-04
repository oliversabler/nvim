function ColorScheme(color)
    color = color or "nord"
    vim.cmd.colorscheme(color)
end

ColorScheme()
