return {
    -- TODO: swap to axelvc when PR merged
    {
        'barrett-ruth/template-string.nvim',
        opts = {
            remove_template_string = true,
        },
    },
    {
        'barrett-ruth/import-cost.nvim',
        build = 'sh install.sh yarn',
        config = true,
        ft = { 'javascript', 'javascripreact', 'typescript', 'typescriptreact' },
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function(_, opts)
            local gitsigns = require('gitsigns')
            gitsigns.setup(opts)

            map({ 'n', '<leader>gb', gitsigns.blame_line })
            map({ 'n', '<leader>gp', gitsigns.preview_hunk })
            map({ 'n', '[g', gitsigns.prev_hunk })
            map({ 'n', ']g', gitsigns.next_hunk })
        end,
        event = 'VeryLazy',
        opts = {
            on_attach = function()
                vim.wo.signcolumn = 'yes'
            end,
            attach_to_untracked = false,
            signs = {
                delete = { text = '＿' },
            },
        },
    },
    {
        'monaqa/dial.nvim',
        config = function()
            local augend = require('dial.augend')

            require('dial.config').augends:register_group({
                default = {
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
        'stevearc/oil.nvim',
        keys = {
            { '-', '<cmd>e .<cr>' },
            { '_', '<cmd>Oil<cr>' },
        },
        opts = {
            skip_confirm_for_simple_edits = true,
            prompt_save_on_select_new_entry = false,
            float = {
                border = 'single',
            },
        },
    },
    { 'windwp/nvim-autopairs', config = true, event = 'InsertEnter' },
}
