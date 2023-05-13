return {
    'nvim-lua/plenary.nvim',
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdateSync',
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
            map({ 'n', '<leader>i', '<cmd>Inspect<cr>' })
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'windwp/nvim-ts-autotag'
        },
        opts = {
            ensure_installed = {
                'bash',
                'c',
                'cmake',
                'comment',
                'cpp',
                'css',
                'diff',
                'dockerfile',
                'git_rebase',
                'gitattributes',
                'gitignore',
                'go',
                'graphql',
                'html',
                'htmldjango',
                'http',
                'java',
                'javascript',
                'jq',
                'json',
                'json5',
                'lua',
                'make',
                'markdown',
                'markdown_inline',
                'python',
                'regex',
                'rust',
                'sql',
                'tsx',
                'typescript',
                'vim',
                'vimdoc',
                'yaml',
            },
            autotag = {
                enable = true
            },
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
                disable = { 'python' },
            },
            context_commentstring = {
                enable = true,
            },
            textobjects = {
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_previous_start = {
                        ['[a'] = '@parameter.inner',
                        ['[c'] = '@class.outer',
                        ['[f'] = '@function.outer',
                        ['[i'] = '@conditional.outer',
                    },
                    goto_previous_end = {
                        ['[A'] = '@parameter.inner',
                        ['[C'] = '@class.outer',
                        ['[F'] = '@function.outer',
                        ['[I'] = '@conditional.outer',
                    },
                    goto_next_start = {
                        [']a'] = '@parameter.inner',
                        [']c'] = '@class.outer',
                        [']f'] = '@function.outer',
                        [']i'] = '@conditional.outer',
                    },
                    goto_next_end = {
                        [']A'] = '@parameter.inner',
                        [']C'] = '@class.outer',
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
                        af = '@function.outer',
                        ['if'] = '@function.inner',
                        ai = '@conditional.outer',
                        ii = '@conditional.inner',
                        aL = '@loop.outer',
                        iL = '@loop.inner',
                        as = '@class.outer',
                        is = '@class.inner',
                    },
                },
            },
        },
    },
    {
        'nvim-treesitter/playground',
        cmd = 'TSPlaygroundToggle',
    },
}
