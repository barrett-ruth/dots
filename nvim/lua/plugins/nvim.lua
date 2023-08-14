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
        config = function()
            vim.g.mkdp_page_title = '${name}'
            vim.g.mkdp_theme = 'light'
        end,
        keys = { { '<leader>m', '<cmd>MarkdownPreviewToggle<cr>' } },
    },
    {
        'm4xshen/smartcolumn.nvim',
        opts = {
            disabled_filetypes = {
                'checkhealth',
                'help',
                'lazy',
                'log',
                'markdown',
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

            map({ 'n', '<c-a>', require('dial.map').inc_normal() })
            map({ 'n', '<c-x>', require('dial.map').dec_normal() })
            map({ 'n', 'g<c-a>', require('dial.map').inc_gnormal() })
            map({ 'n', 'g<c-x>', require('dial.map').dec_gnormal() })
            map({ 'x', '<c-a>', require('dial.map').inc_visual() })
            map({ 'x', '<c-x>', require('dial.map').dec_visual() })
            map({ 'x', 'g<c-a>', require('dial.map').inc_gvisual() })
            map({ 'x', 'g<c-x>', require('dial.map').dec_gvisual() })
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
        config = function()
            require('hop').setup()
            vim.cmd('hi clear HopUnmatched')
        end,
        keys = { { '<leader>h', '<cmd>HopChar2<cr>' } },
    },
    {
        'stevearc/oil.nvim',
        config = function(_, opts)
            require('oil').setup(opts)
            require('colors').link('Directory', 'OilDir')
        end,
        keys = {
            { '-', '<cmd>e .<cr>' },
            { '_', '<cmd>Oil<cr>' },
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
    -- TODO: swap back to windwp (manually remove fork)
    { 'barrett-ruth/nvim-autopairs', config = true, event = 'InsertEnter' },
}
