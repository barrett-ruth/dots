return {
    {
        'kristijanhusak/vim-dadbod-ui',
        config = function()
            vim.g.db_ui_show_help = 0
            map { 'n', '<leader>D', '<cmd>DBUIToggle<cr>' }
        end,
    },
    'sainnhe/gruvbox-material',
    'tpope/vim-abolish',
    {
        'tpope/vim-dadbod',
        config = function()
            map({ 'n', '<leader>d', ':DB ' }, { silent = false })
        end,
    },
    'tpope/vim-repeat',
    'tpope/vim-surround',
}
