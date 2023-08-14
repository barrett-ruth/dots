-- stylua: ignore
local ts_langs = {
    'bash', 'c', 'cmake', 'comment',
    'cpp', 'css', 'diff', 'dockerfile',
    'git_rebase', 'gitattributes', 'gitignore',
    'go', 'graphql', 'html', 'htmldjango',
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
        'kevinhwang91/nvim-ufo',
        config = function(_, opts)
            vim.o.foldenable = true
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99

            require('ufo').setup(opts)

            local colors = require('colors')
            colors.hi(
                'UfoFoldedEllipsis',
                { fg = colors[vim.g.colors_name].dark_grey }
            )
        end,
        dependencies = {
            'kevinhwang91/promise-async',
            'nvim-treesitter/nvim-treesitter',
        },
        keys = {
            { 'zM', '<cmd>lua require("ufo").closeAllFolds()<cr>' },
            { 'zR', '<cmd>lua require("ufo").openAllFolds()<cr>' },
            {
                '[z',
                '<cmd>lua require("ufo").goPreviousStartFold()<cr>',
            },
        },
        opts = {
            open_fold_hl_timeout = 0,
            provider_selector = function()
                return { 'treesitter', 'indent' }
            end,
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
        keys = { { '<leader>i', '<cmd>Inspect<cr>' } },
        opts = {
            ensure_installed = ts_langs,
            highlight = { enable = true },
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
        dependencies = 'nvim-treesitter/nvim-treesitter',
        keys = { { '<leader>t', '<cmd>TSPlaygroundToggle<cr>' } },
    },
    {
        'windwp/nvim-ts-autotag',
        config = true,
        dependencies = 'nvim-treesitter/nvim-treesitter',
    },
}
