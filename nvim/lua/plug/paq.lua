require 'paq' {
    'savq/paq-nvim',

    'neovim/nvim-lspconfig',
    'jose-elias-alvarez/null-ls.nvim',
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    'onsails/lspkind-nvim',

    { 'hrsh7th/nvim-cmp', branch = 'dev' },
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',

    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

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
    'nvim-treesitter/nvim-treesitter-textobjects',

    'lukas-reineke/indent-blankline.nvim',
    'sainnhe/gruvbox-material',

    'famiu/bufdelete.nvim',
    'gpanders/editorconfig.nvim',
    'lewis6991/impatient.nvim',
    'lewis6991/gitsigns.nvim',
    'nathom/filetype.nvim',
    'numToStr/Comment.nvim',
    'nvim-lualine/lualine.nvim',
    'rmagatti/auto-session',
    'stevearc/aerial.nvim',

    'ThePrimeagen/git-worktree.nvim',
    'ThePrimeagen/refactoring.nvim',
    'ThePrimeagen/harpoon',

    'tpope/vim-abolish',
    'tpope/vim-fugitive',
    'tpope/vim-repeat',
    'tpope/vim-surround',
}

local utils = require 'utils'
local mapstr = utils.mapstr
local map = utils.map

map { 'n', '<leader>Pc', mapstr 'PaqClean' }
map { 'n', '<leader>Pi', mapstr 'PaqInstall' }
map { 'n', '<leader>Pl', mapstr 'PaqList' }
map { 'n', '<leader>PL', mapstr 'PaqLogOpen' }
map { 'n', '<leader>Pu', mapstr 'PaqUpdate' }
