local treesitter_configs = require 'nvim-treesitter.configs'

treesitter_configs.setup {
    ensure_installed = {
        'bash',
        'c',
        'cpp',
        'css',
        'dockerfile',
        'go',
        'html',
        'http',
        'java',
        'javascript',
        'json',
        'lua',
        'make',
        'python',
        'tsx',
        'typescript',
        'vim',
        'yaml',
    },
    sync_install = false,
    ignore_install = {},
    indent = {
        enable = false,
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
}
