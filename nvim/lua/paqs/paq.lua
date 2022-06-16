require 'paq' {
    'savq/paq-nvim',

    'neovim/nvim-lspconfig',
    'jose-elias-alvarez/null-ls.nvim',
    'jose-elias-alvarez/nvim-lsp-ts-utils',

    'L3MON4D3/LuaSnip',

    'nvim-lua/plenary.nvim',
    {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            vim.cmd 'TSUpdate'
        end,
    },
    'nvim-treesitter/nvim-treesitter-textobjects',

    'kyazdani42/nvim-tree.lua',
    'nvim-lualine/lualine.nvim',
    'sainnhe/gruvbox-material',
    'SmiteshP/nvim-navic',

    'Julian/vim-textobj-variable-segment',
    'kana/vim-textobj-user',
    'vimtaku/vim-textobj-keyvalue',
    'whatyouhide/vim-textobj-xmlattr',

    'tpope/vim-abolish',
    'tpope/vim-fugitive',
    'tpope/vim-repeat',
    'tpope/vim-surround',

    'andymass/vim-matchup',
    'ibhagwan/fzf-lua',
    'lewis6991/impatient.nvim',
    'lewis6991/gitsigns.nvim',
    'numToStr/Comment.nvim',
    'ojroques/nvim-bufdel',
    'wellle/targets.vim',

    'ThePrimeagen/harpoon',
    'ThePrimeagen/git-worktree.nvim',
}

local utils = require 'utils'
local map, mapstr = utils.map, utils.mapstr

map { 'n', '<leader>Pc', mapstr 'PaqClean' }
map { 'n', '<leader>Pi', mapstr 'PaqInstall' }
map { 'n', '<leader>Pu', mapstr 'PaqUpdate' }
map { 'n', '<leader>Pl', mapstr 'PaqLogOpen' }
