require('treesitter-context').setup {
    max_lines = 1,
    patterns = {
        default = {
            'class',
            'function',
            'method',
            'switch',
            'case',
        },
    },
}

require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'c',
        'comment',
        'cpp',
        'css',
        'dockerfile',
        'gitignore',
        'go',
        'graphql',
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
        'sql',
        'tsx',
        'typescript',
        'vim',
        'yaml',
    },
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
            goto_previous_start = {
                ['[a'] = '@parameter.inner',
                ['[c'] = '@call.outer',
                ['[s'] = '@class.outer',
                ['[f'] = '@function.outer',
                ['[i'] = '@conditional.outer',
                ['[/'] = '@comment.outer',
            },
            goto_previous_end = {
                ['[A'] = '@parameter.inner',
                ['[C'] = '@call.outer',
                ['[S'] = '@class.outer',
                ['[F'] = '@function.outer',
                ['[I'] = '@conditional.outer',
            },
            goto_next_start = {
                [']a'] = '@parameter.inner',
                [']c'] = '@call.outer',
                [']s'] = '@class.outer',
                [']f'] = '@function.outer',
                [']i'] = '@conditional.outer',
                [']/'] = '@comment.outer',
            },
            goto_next_end = {
                [']A'] = '@parameter.inner',
                [']C'] = '@call.outer',
                [']S'] = '@class.outer',
                [']F'] = '@function.outer',
                [']I'] = '@conditional.outer',
            },
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
                ['i/'] = '@comment.inner',
                ['a/'] = '@comment.outer',
            },
        },
    },
}

local utils = require 'utils'

utils.map {
    'n',
    '<c-h>',
    utils.mapstr 'TSHighlightCapturesUnderCursor',
}
