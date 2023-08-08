return {
    {
        'lewis6991/gitsigns.nvim',
        config = function(_, opts)
            local gitsigns = require('gitsigns')
            gitsigns.setup(opts)

            local colors = require('colors')
            colors.link('DiffAdd', 'GitSignsAdd')
            colors.link('DiffChange', 'GitSignsChange')
            colors.link('DiffDelete', 'GitSignsDelete')
            colors.hi(
                'GitSignsCurrentLineBlame',
                { italic = true, fg = colors[vim.g.colors_name].light_black }
            )

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
        'ruifm/gitlinker.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        keys = {
            {
                '<leader>gy',
                '<cmd>lua require("gitlinker").get_buf_range_url("n")<cr>',
            },
            {
                '<leader>gy',
                '<cmd>lua require("gitlinker").get_buf_range_url("v")<cr>',
                mode = 'x',
            },
        },
        opts = {
            opts = { print_url = false },
        },
    },
    { 'tpope/vim-fugitive', event = 'VeryLazy' },
}
