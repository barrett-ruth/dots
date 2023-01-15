return {
    'nvim-lua/plenary.nvim',
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdateSync',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-context',
            'nvim-treesitter/nvim-treesitter-textobjects',
            'windwp/nvim-ts-autotag',
        },
        config = function()
            require('nvim-treesitter.configs').setup {
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
                indent = { enable = false },
                highlight = {
                    enable = true,
                    disable = function(_, bufnr)
                        return vim.api.nvim_buf_line_count(bufnr) > 10e3
                    end,
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
        end,
        keys = {
            { '<leader>i', '<cmd>Inspect<cr>' },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
            require('treesitter-context').setup {
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
            }
        end,
    },
    {
        'nvim-treesitter/playground',
        cmd = 'TSPlaygroundToggle',
        lazy = true,
    },
    {
        'Wansmer/treesj',
        keys = {
            { 'gJ', '<cmd>TSJJoin<cr>' },
            { 'gS', '<cmd>TSJSplit<cr>' },
        },
        lazy = true,
        opts = {
            use_default_keymaps = false,
        },
    },
}
