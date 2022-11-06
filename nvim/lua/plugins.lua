local paq = require 'paq'

paq {
    'savq/paq-nvim',

    'folke/neodev.nvim',
    'kristijanhusak/vim-dadbod-ui',
    'nanotee/sqls.nvim',
    'neovim/nvim-lspconfig',

    'andymass/vim-matchup',

    'AndrewRadev/splitjoin.vim',

    {
        'iamcco/markdown-preview.nvim',
        run = function() vim.fn['mkdp#util#install']() end,
    },

    'echasnovski/mini.ai',
    'echasnovski/mini.align',
    'echasnovski/mini.bufremove',
    'echasnovski/mini.comment',
    'echasnovski/mini.cursorword',
    'echasnovski/mini.pairs',

    'elihunter173/dirbuf.nvim',

    'jose-elias-alvarez/null-ls.nvim',
    'jose-elias-alvarez/typescript.nvim',

    'Julian/vim-textobj-variable-segment',
    'kana/vim-textobj-indent',
    'kana/vim-textobj-user',
    'vimtaku/vim-textobj-keyvalue',
    'whatyouhide/vim-textobj-xmlattr',

    'lewis6991/impatient.nvim',
    'lewis6991/gitsigns.nvim',

    'L3MON4D3/LuaSnip',

    'monaqa/dial.nvim',

    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-fzy-native.nvim',

    'nvim-lua/plenary.nvim',
    {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update { with_sync = true } end,
    },
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/playground',

    'NvChad/nvim-colorizer.lua',

    'phaazon/hop.nvim',

    'tommcdo/vim-exchange',

    'tpope/vim-abolish',
    'tpope/vim-dadbod',
    'tpope/vim-fugitive',
    'tpope/vim-repeat',
    'tpope/vim-sleuth',
    'tpope/vim-surround',

    'ThePrimeagen/harpoon',
    'ThePrimeagen/git-worktree.nvim',
}

map { 'n', '<leader>Pi', paq.install }
map { 'n', '<leader>Pc', paq.clean }
map { 'n', '<leader>Pl', paq.list }
map { 'n', '<leader>PL', paq.log_open }
map { 'n', '<leader>Pu', paq.update }