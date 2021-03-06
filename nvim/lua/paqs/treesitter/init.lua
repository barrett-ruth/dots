local ensure_installed = {
    'bash',
    'c',
    'cpp',
    'css',
    'dockerfile',
    'html',
    'http',
    'javascript',
    'json',
    'lua',
    'make',
    'markdown',
    'markdown_inline',
    'python',
    'query',
    'tsx',
    'typescript',
    'vim',
    'yaml',
}

require('nvim-treesitter.configs').setup {
    ensure_installed = ensure_installed,
    indent = {
        enable = false,
    },
    highlight = {
        enable = true,
    },
    textobjects = {
        move = {
            enable = true,
            set_jumps = true,
        },
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ab = '@block.outer',
                ib = '@block.inner',
                af = '@function.outer',
                ['if'] = '@function.inner',
                ac = '@call.outer',
                ic = '@call.inner',
                aC = '@class.outer',
                iC = '@class.inner',
                ai = '@conditional.outer',
                ii = '@conditional.inner',
                aL = '@loop.outer',
                iL = '@loop.inner',
                aa = '@parameter.outer',
                ia = '@parameter.inner',
            },
        },
    },
}

require 'paqs.treesitter.map'
