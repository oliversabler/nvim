local treesitter_parser_config = require'nvim-treesitter.parsers'.get_parser_configs()

require'treesitter-context'.setup{}

require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        'c',
        'go',
        'lua',
        'python',
        'vim',
        'vimdoc',
        'query',
        'markdown',
        'markdown_inline'
    },

    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
