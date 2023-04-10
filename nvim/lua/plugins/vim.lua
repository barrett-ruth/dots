return {
    {
        'kristijanhusak/vim-dadbod-ui',
        config = function()
            vim.g.db_ui_show_help = 0
            map { 'n', '<leader>D', '<cmd>DBUIToggle<cr>' }
        end,
    },
    {
        'sainnhe/gruvbox-material',
        config = function()
            vim.g.gruvbox_material_better_performance = 1

            vim.cmd [[
                colorscheme gruvbox-material
                for e in ['NormalFloat', 'HintFloat', 'InfoFloat', 'ErrorFloat', 'WarningFloat', 'FloatBorder']
                    exe 'hi ' . e . ' guibg=#282828'
                endfo
                hi @field.lua guifg=#d4be98
            ]]
        end,
    },
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
