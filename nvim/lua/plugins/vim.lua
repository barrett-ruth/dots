return {
    {
        'lervag/vimtex',
        config = function()
            vim.g.vimtex_quickfix_ignore_filters = { 'Overfull \\\\hbox' }
        end,
        ft = 'tex',
        keys = { { '<leader>v', vim.cmd.VimtexCompile } },
    },
    {
        'maxmellon/vim-jsx-pretty',
        ft = {
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
        },
    },
    { 'tpope/vim-abolish', event = 'VeryLazy' },
    { 'tpope/vim-dadbod', event = 'VeryLazy' },
    { 'tpope/vim-repeat', event = 'VeryLazy' },
    'tpope/vim-sleuth',
    { 'tpope/vim-surround', event = 'VeryLazy' },
    { 'Vimjas/vim-python-pep8-indent', ft = { 'python' } },
}
