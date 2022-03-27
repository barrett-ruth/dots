local treesitter_configs = require 'nvim-treesitter.configs'

require('nvim-treesitter.configs').setup {
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                af = '@function.outer',
                ['if'] = '@function.inner',
                ac = '@conditional.outer',
                ['ic'] = '@conditional.inner',
                al = '@loop.outer',
                ['il'] = '@loop.inner',
                aa = '@parameter.outer',
                ['ia'] = '@parameter.inner',
            },
        },
    },
}

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

local utils = require 'utils'
local map = utils.map
local mapstr = utils.mapstr

map { 'n', '<leader>T', mapstr('utils', 'sitter_reparse()') }
