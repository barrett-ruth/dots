-- stylua: ignore
local ts_langs = {
    'bash', 'c', 'cmake', 'comment',
    'cpp', 'css', 'diff', 'dockerfile',
    'git_rebase', 'gitattributes', 'gitignore',
    'go', 'gomod', 'gosum', 'html', 'htmldjango',
    'http', 'java', 'javascript', 'jq',
    'json', 'json5', 'lua', 'make', 'markdown',
    'markdown_inline', 'python', 'regex',
    'query', 'rust', 'sql', 'tsx',
    'typescript', 'vim', 'vimdoc', 'yaml',
}

return {
    {
        'CKolkey/ts-node-action',
        config = true,
        dependencies = 'nvim-treesitter/nvim-treesitter',
        keys = {
            { 'gS', '<cmd>lua require("ts-node-action").node_action()<cr>' },
        },
    },
    {
        'David-Kunz/treesitter-unit',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        keys = {
            {
                'iu',
                '<cmd>lua require("treesitter-unit").select()<cr>',
                mode = 'x',
            },
            {
                'au',
                '<cmd>lua require("treesitter-unit").select(true)<cr>',
                mode = 'x',
            },
            {
                'iu',
                '<cmd>lua require("treesitter-unit").select()<cr>',
                mode = 'o',
            },
            {
                'au',
                '<cmd>lua require("treesitter-unit").select(true)<cr>',
                mode = 'o',
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdateSync',
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-lua/plenary.nvim',
        },
        ft = ts_langs,
        keys = { { '<leader>i', vim.cmd.Inspect } },
        opts = {
            ensure_installed = ts_langs,
            highlight = {
                additional_vim_regex_highlighting = true,
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
                        ['[/'] = '@comment.outer',
                    },
                    goto_previous_end = {
                        ['[A'] = '@parameter.inner',
                        ['[F'] = '@function.outer',
                        ['[I'] = '@conditional.outer',
                    },
                    goto_next_start = {
                        [']a'] = '@parameter.inner',
                        [']c'] = '@class.outer',
                        [']f'] = '@function.outer',
                        [']i'] = '@conditional.outer',
                        [']/'] = '@comment.outer',
                    },
                    goto_next_end = {
                        [']A'] = '@parameter.inner',
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
                        ac = '@class.outer',
                        ic = '@class.inner',
                        aC = '@call.outer',
                        iC = '@call.inner',
                        af = '@function.outer',
                        ['if'] = '@function.inner',
                        ai = '@conditional.outer',
                        ii = '@conditional.inner',
                        aL = '@loop.outer',
                        iL = '@loop.inner',
                    },
                },
            },
        },
    },
}
