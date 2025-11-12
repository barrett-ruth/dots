return {
    { 'tpope/vim-fugitive' },
    {
        'folke/snacks.nvim',
        ---@type snacks.Config
        config = true,
        keys = {
            { '<leader>go', '<cmd>lua Snacks.gitbrowser()<cr>' },
            { '<leader>gi', '<cmd>lua Snacks.picker.gh_issue()<cr>' },
            { '<leader>gp', '<cmd>lua Snacks.picker.gh_pr()<cr>' },
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        keys = {
            { '[g', '<cmd>Gitsigns next_hunk<cr>' },
            { ']g', '<cmd>Gitsigns prev_hunk<cr>' },
        },
        event = 'VeryLazy',
        opts = {
            on_attach = function()
                vim.wo.signcolumn = 'yes'
            end,
            current_line_blame_formatter_nc = function()
                return {}
            end,
            attach_to_untracked = false,
            signcolumn = false,
            signs = {
                -- use boxdraw chars
                add = { text = '│' },
                change = { text = '│' },
                delete = { text = '＿' },
                topdelete = { text = '‾' },
                changedelete = { text = '│' },
            },
            current_line_blame = true,
        },
    },
}
