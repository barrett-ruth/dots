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
        'numToStr/Comment.nvim',
        event = 'VeryLazy',
        opts = function()
            return {
                pre_hook = require(
                    'ts_context_commentstring.integrations.comment_nvim'
                ).create_pre_hook(),
            }
        end,
    },
    {
        'nvim-treesitter/playground',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        keys = { { '<leader>t', '<cmd>TSPlaygroundToggle<cr>' } },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdateSync',
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
        dependencies = {
            {
                'CKolkey/ts-node-action',
                config = true,
                keys = {
                    {
                        'gS',
                        '<cmd>lua require("ts-node-action").node_action()<cr>',
                    },
                },
            },
            {
                'David-Kunz/treesitter-unit',
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
                        '<cmd><c-u>lua require("treesitter-unit").select()<cr>',
                        mode = 'o',
                    },
                    {
                        'au',
                        '<cmd><c-u>lua require("treesitter-unit").select(true)<cr>',
                        mode = 'o',
                    },
                },
            },
            'JoosepAlviste/nvim-ts-context-commentstring',
            { 'nvim-lua/plenary.nvim', lazy = true },
            'nvim-treesitter/nvim-treesitter-textobjects',
            {
                'kevinhwang91/nvim-ufo',
                init = function()
                    vim.o.foldenable = true
                    vim.o.foldlevel = 99
                    vim.o.foldlevelstart = 99
                end,
                dependencies = { 'kevinhwang91/promise-async' },
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
                'windwp/nvim-ts-autotag',
                opts = {
                    filetypes = {
                        'html',
                        'htmldjango',
                        'javascript',
                        'javascriptreact',
                        'typescript',
                        'typescriptreact',
                        'xml',
                    },
                },
            },
        },
        ft = ts_langs,
        keys = {
            { '<leader>i', '<cmd>Inspect<cr>' },
        },
        opts = {
            autotag = { enable = true },
            ensure_installed = ts_langs,
            highlight = { enable = true },
            context_commentstring = { enable = true },
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
}
