return {
    { 'nvim-lua/plenary.nvim' },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdateSync',
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
        dependencies = {
            {
                'andymass/vim-matchup',
                config = function()
                    vim.g.matchup_matchparen_offscreen = {}
                end,
            },
            {
                'nvim-treesitter/nvim-treesitter-context',
                opts = {
                    max_lines = 2,
                    patterns = {
                        default = {
                            'class',
                            'function',
                            'method',
                            'switch',
                            'case',
                            'interface',
                            'struct',
                            'enum',
                        },
                    },
                },
                config = function(_, opts)
                    require('treesitter-context').setup(opts)
                end,
            },
            'nvim-treesitter/nvim-treesitter-textobjects',
            'windwp/nvim-ts-autotag',
        },
        opts = {
            ensure_installed = 'all',
            autotag = {
                enable = true,
                filetypes = {
                    'html',
                    'htmldjango',
                    'javascriptreact',
                    'typescriptreaact',
                },
            },
            highlight = {
                enable = true,
                disable = function(_, bufnr)
                    return vim.api.nvim_buf_line_count(bufnr) > 10e3
                end,
            },
            context_commentstring = {
                enable = true,
            },
            matchup = {
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
        },
        keys = {
            { '<leader>i', '<cmd>Inspect<cr>' },
        },
    },
    {
        'nvim-treesitter/playground',
        cmd = 'TSPlaygroundToggle',
    },
    {
        'Wansmer/treesj',
        keys = {
            { 'gJ', '<cmd>TSJJoin<cr>' },
            { 'gS', '<cmd>TSJSplit<cr>' },
        },
        opts = {
            use_default_keymaps = false,
        },
    },
}
