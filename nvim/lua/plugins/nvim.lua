return {
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
            require('gitsigns').setup(opts)

            map({ 'n', '<leader>gb', '<cmd>Gitsigns blame_line<cr>' })
            map({ 'n', '<leader>gp', '<cmd>Gitsigns preview_hunk<cr>' })
            map({
                'n',
                '[g',
                '<cmd>lua require("gitsigns").prev_hunk { preview = true }<cr>',
            })
            map({
                'n',
                ']g',
                '<cmd>lua require("gitsigns").next_hunk { preview = true }<cr>',
            })
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
