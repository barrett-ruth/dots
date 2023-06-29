return {
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                pre_hook = require(
                    'ts_context_commentstring.integrations.comment_nvim'
                ).create_pre_hook(),
            })
        end,
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
        event = 'VeryLazy',
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdateSync',
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
        dependencies = {
            { 'nvim-lua/plenary.nvim', event = 'VeryLazy' },
            'nvim-treesitter/nvim-treesitter-textobjects',
            {
                'kevinhwang91/nvim-ufo',
                init = function()
                    vim.o.foldenable = true
                    vim.o.foldlevel = 99
                    vim.o.foldlevelstart = 99
                    vim.o.foldminlines = 20
                end,
                dependencies = { 'kevinhwang91/promise-async' },
                keys = {
                    { 'zM', '<cmd>lua require("ufo").closeAllFolds()<cr>' },
                    { 'zR', '<cmd>lua require("ufo").openAllFolds()<cr>' },
                    { '[z', '<cmd>lua require("ufo").goPreviousClosedFold()<cr>' },
                    { ']z', '<cmd>lua require("ufo").goNextClosedFold()<cr>' }
                },
                opts = {
                    provider_selector = function()
                        return { 'treesitter', 'indent' }
                    end,
                },
            },
        },
        keys = {
            { '<leader>i', '<cmd>Inspect<cr>' },
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
}
