return {
    {
        'barrett-ruth/import-cost.nvim',
        build = 'sh install.sh yarn',
        config = true,
        ft = { 'javascript', 'javascripreact', 'typescript', 'typescriptreact' },
    },
    {
        'iamcco/markdown-preview.nvim',
        build = 'yarn --cwd app install',
        config = function()
            vim.g.mkdp_auto_close = 0
            vim.g.mkdp_refresh_slow = 1
            vim.g.mkdp_page_title = '${name}'
        end,
        ft = 'markdown',
        keys = {
            { '<leader>m', '<cmd>MarkdownPreviewToggle<cr>' },
        },
    },
    {
        'elihunter173/dirbuf.nvim',
        opts = {
            sort_order = 'directories_first',
        },
        config = function(_, opts)
            require('dirbuf').setup(opts)
            map { 'n', '-', '<cmd>e .<cr>' }
            map {
                'n',
                '_',
                '<cmd>e %:h<cr>',
            }
        end,
    },
    {
        'laytan/cloak.nvim',
        opts = {
            cloak_length = 10,
        },
        keys = {
            { '<leader>c', '<cmd>CloakToggle<cr>' },
        },
        lazy = false,
    },
    {
        'monaqa/dial.nvim',
        config = function()
            local dial = require 'dial.map'
            map { 'n', '<c-a>', dial.inc_normal() }
            map { 'n', '<c-x>', dial.dec_normal() }
            map { 'n', 'g<c-a>', dial.inc_gnormal() }
            map { 'n', 'g<c-x>', dial.dec_gnormal() }
            map { 'x', '<c-a>', dial.inc_visual() }
            map { 'x', '<c-x>', dial.dec_visual() }
            map { 'x', 'g<c-a>', dial.inc_gvisual() }
            map { 'x', 'g<c-x>', dial.dec_gvisual() }
        end,
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup {
                pre_hook = require(
                    'ts_context_commentstring.integrations.comment_nvim'
                ).create_pre_hook(),
            }
        end,
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
        event = 'VeryLazy',
    },
    {
        'NvChad/nvim-colorizer.lua',
        event = 'BufReadPre',
        ft = vim.g.markdown_fenced_languages,
        opts = {
            filetypes = vim.g.markdown_fenced_languages,
            user_default_options = {
                RRGGBBAA = true,
                AARRGGBB = true,
                css = true,
                rgb_fun = true,
                hsl_fn = true,
                tailwind = true,
                mode = 'foreground',
            },
        },
    },
    {
        'phaazon/hop.nvim',
        config = true,
        keys = { { '<leader>h', '<cmd>HopChar2<cr>' } },
    },
}
