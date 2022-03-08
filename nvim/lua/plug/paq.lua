require 'paq' {
    'savq/paq-nvim',

    'neovim/nvim-lspconfig',
    'jose-elias-alvarez/nvim-lsp-ts-utils',

    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',

    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
    'nvim-telescope/telescope-fzy-native.nvim',
    {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            vim.cmd 'TSUpdate'
        end,
    },

    'L3MON4D3/LuaSnip',

    'lifepillar/vim-gruvbox8',

    'lewis6991/gitsigns.nvim',

    'nvim-lualine/lualine.nvim',

    'rmagatti/auto-session',

    'sbdchd/neoformat',

    'ThePrimeagen/git-worktree.nvim',
    'ThePrimeagen/harpoon',

    'tpope/vim-abolish',
    'tpope/vim-commentary',
    'tpope/vim-fugitive',
    'tpope/vim-repeat',
    'tpope/vim-sleuth',
    'tpope/vim-surround',
}

local utils = require 'utils'
local mapstr = utils.mapstr
local map = utils.map

local paqleader = '<leader>P'

map { 'n', paqleader .. 'c', mapstr 'PaqClean' }
map { 'n', paqleader .. 'i', mapstr 'PaqInstall' }
map { 'n', paqleader .. 'l', mapstr 'PaqList' }
map { 'n', paqleader .. 'L', mapstr 'PaqLogOpen' }
map { 'n', paqleader .. 'u', mapstr 'PaqUpdate' }
