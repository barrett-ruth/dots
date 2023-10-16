return {
    {
        'axelvc/template-string.nvim',
        opts = {
            remove_template_string = true,
        },
    },
    {
        'barrett-ruth/import-cost.nvim',
        build = 'sh install.sh yarn',
        config = true,
        ft = {
            'javascript',
            'javascripreact',
            'typescript',
            'typescriptreact',
        },
    },
    {
        'iamcco/markdown-preview.nvim',
        build = 'yarn install --cwd app',
        ft = { 'markdown' },
        init = function()
            vim.g.mkdp_page_title = '${name}'
            vim.g.mkdp_theme = 'light'
        end,
        keys = { { '<leader>m', vim.cmd.MarkdownPreviewToggle } },
    },
    {
        'm4xshen/smartcolumn.nvim',
        opts = {
            disabled_filetypes = {
                '',
                'checkhealth',
                'help',
                'lazy',
                'log',
                'lspinfo',
                'markdown',
                'man',
                'NvimTree',
                'text',
            },
        },
    },
    {
        'monaqa/dial.nvim',
        config = function()
            local augend = require('dial.augend')

            require('dial.config').augends:register_group({
                default = {
                    augend.constant.alias.alpha,
                    augend.constant.alias.Alpha,
                    augend.constant.alias.bool,
                    augend.constant.new({
                        elements = { 'and', 'or' },
                        word = true,
                        cyclic = true,
                    }),
                    augend.constant.new({
                        elements = { '&&', '||' },
                        word = false,
                        cyclic = true,
                    }),
                },
            })

            local dmap = require('dial.map')

            map({
                'n',
                '<c-a>',
                function()
                    dmap.manipulate('increment', 'normal')
                end,
            })
            map({
                'n',
                '<c-x>',
                function()
                    dmap.manipulate('decrement', 'normal')
                end,
            })
            map({
                'n',
                'g<c-a>',
                function()
                    dmap.manipulate('increment', 'gnormal')
                end,
            })
            map({
                'n',
                'g<c-x>',
                function()
                    dmap.manipulate('decrement', 'gnormal')
                end,
            })
            map({
                'x',
                '<c-a>',
                function()
                    dmap.manipulate('increment', 'visual')
                end,
            })
            map({
                'x',
                '<c-x>',
                function()
                    dmap.manipulate('decrement', 'visual')
                end,
            })
            map({
                'x',
                'g<c-a>',
                function()
                    dmap.manipulate('increment', 'gvisual')
                end,
            })
            map({
                'x',
                'g<c-x>',
                function()
                    dmap.manipulate('decrement', 'gvisual')
                end,
            })
        end,
    },
    {
        'NvChad/nvim-colorizer.lua',
        opts = {
            filetypes = {
                'conf',
                'sh',
                'tmux',
                'zsh',
                unpack(vim.g.markdown_fenced_languages),
            },
            user_default_options = {
                RRGGBBAA = true,
                AARRGGBB = true,
                css = true,
                rgb_fun = true,
                hsl_fn = true,
                tailwind = true,
            },
        },
    },
    {
        'phaazon/hop.nvim',
        config = true,
        keys = { { 'H', vim.cmd.HopChar2 } },
    },
    {
        'stevearc/oil.nvim',
        keys = {
            { '-', '<cmd>e .<cr>' },
            { '_', vim.cmd.Oil },
        },
        lazy = false,
        opts = {
            skip_confirm_for_simple_edits = true,
            prompt_save_on_select_new_entry = false,
            float = {
                border = 'single',
            },
        },
    },
    {
        'tzachar/highlight-undo.nvim',
        config = true,
        event = 'VeryLazy',
    },
    {
        'nvimdev/guard.nvim',
        config = function()
            require('guard.filetype')('javascript'):fmt({
                cmd = 'prettierd',
                fname = true,
                stdin = true,
            })
            require('guard').setup()
        end,
        dependencies = { 'nvimdev/guard-collection' },
    },
}
