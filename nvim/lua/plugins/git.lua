return {
    {
        'lewis6991/gitsigns.nvim',
        config = function(_, opts)
            local gitsigns = require('gitsigns')
            gitsigns.setup(opts)

            map({ 'n', '<leader>gb', gitsigns.toggle_current_line_blame })
            map({ 'n', '<leader>gp', gitsigns.preview_hunk })
            map({ 'n', '<leader>gs', gitsigns.stage_hunk })
            map({ 'n', '<leader>gS', gitsigns.undo_stage_hunk })
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
                '<leader>gl',
                '<cmd>lua require("gitlinker").get_buf_range_url("n")<cr>',
            },
            {
                '<leader>gl',
                '<cmd>lua require("gitlinker").get_buf_range_url("v")<cr>',
                mode = 'x',
            },
        },
        opts = {
            opts = { print_url = false },
        },
    },
    'tpope/vim-fugitive',
}
