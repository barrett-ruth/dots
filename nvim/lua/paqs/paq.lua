require 'paq' {
    'savq/paq-nvim',

    -- cmp [:
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    -- :]

    -- lsp [:
    'neovim/nvim-lspconfig',
    'b0o/SchemaStore.nvim',
    'folke/lua-dev.nvim',
    'jose-elias-alvarez/null-ls.nvim',
    'jose-elias-alvarez/typescript.nvim',
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    'p00f/clangd_extensions.nvim',
    -- :]

    -- treesitter [:
    'lewis6991/spellsitter.nvim',
    'nvim-lua/plenary.nvim',
    {
        'nvim-treesitter/nvim-treesitter',
        run = function() vim.cmd 'TSUpdate' end,
    },
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/playground',
    -- :]

    -- cosmetic [:
    'RRethy/vim-hexokinase',
    'SmiteshP/nvim-navic',
    -- :]

    -- primeagen [:
    'ThePrimeagen/harpoon',
    'ThePrimeagen/git-worktree.nvim',
    -- :]

    -- textobjects [:
    'Julian/vim-textobj-variable-segment',
    'kana/vim-textobj-entire',
    'kana/vim-textobj-fold',
    'kana/vim-textobj-user',
    'vimtaku/vim-textobj-keyvalue',
    'whatyouhide/vim-textobj-xmlattr',
    -- :]

    -- tpope [:
    'tpope/vim-abolish',
    'tpope/vim-fugitive',
    'tpope/vim-repeat',
    'tpope/vim-surround',
    -- :]

    -- misc [:
    'andymass/vim-matchup',
    {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
    },
    'ibhagwan/fzf-lua',
    'junegunn/vim-easy-align',
    'wellle/targets.vim',

    'elihunter173/dirbuf.nvim',
    'lewis6991/impatient.nvim',
    'lewis6991/gitsigns.nvim',
    'L3MON4D3/LuaSnip',
    'numToStr/Comment.nvim',
    'ojroques/nvim-bufdel',
    -- :]
}

local utils = require 'utils'
local map, mapstr = utils.map, utils.mapstr

map { 'n', '<leader>Pc', mapstr 'PaqClean' }
map { 'n', '<leader>Pi', mapstr 'PaqInstall' }
map { 'n', '<leader>Pu', mapstr 'PaqUpdate' }
map { 'n', '<leader>Pl', mapstr 'PaqLogOpen' }
map { 'n', '<leader>PL', mapstr 'PaqList' }
