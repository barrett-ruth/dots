require('treesitter-context').setup {
    max_lines = 1,
}

require('treesj').setup {
    use_default_keymaps = false,
}

require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'c',
        'comment',
        'cpp',
        'css',
        'dockerfile',
        'gitignore',
        'graphql',
        'html',
        'http',
        'java',
        'javascript',
        'json',
        'lua',
        'make',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'regex',
        'rust',
        'sql',
        'tsx',
        'typescript',
        'vim',
        'yaml',
    },
    indent = { enable = false },
    highlight = {
        enable = true,
        disable = function(_)
            return vim.fn.getfsize(vim.fn.expand '%') / 10e5 > 20
        end,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
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
                aa = '@parameter.outer',
                ia = '@parameter.inner',
                ab = '@block.outer',
                ib = '@block.inner',
                ac = '@call.outer',
                ic = '@call.inner',
                aC = '@class.outer',
                iC = '@class.inner',
                af = '@function.outer',
                ['if'] = '@function.inner',
                ai = '@conditional.outer',
                ii = '@conditional.inner',
                aL = '@loop.outer',
                iL = '@loop.inner',
                ['a/'] = '@comment.outer',
                ['i/'] = '@comment.inner',
            },
        },
    },
}

map { 'n', '<leader>i', '<cmd>Inspect<cr>' }
