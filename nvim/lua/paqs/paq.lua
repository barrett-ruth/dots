require 'paq' {
    'savq/paq-nvim',

    'lewis6991/impatient.nvim',

    -- cmp [:
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'petertriho/cmp-git',
    'davidsierradz/cmp-conventionalcommits',
    -- :]

    -- lsp [:
    'b0o/SchemaStore.nvim',
    'folke/neodev.nvim',
    'jose-elias-alvarez/null-ls.nvim',
    'jose-elias-alvarez/typescript.nvim',
    'mfussenegger/nvim-jdtls',
    'neovim/nvim-lspconfig',
    'p00f/clangd_extensions.nvim',

    -- postgres [:
    'kristijanhusak/vim-dadbod-ui',
    'kristijanhusak/vim-dadbod-completion',
    'nanotee/sqls.nvim',
    'tpope/vim-dadbod',
    -- :]
    -- :]

    -- treesitter [:
    'nvim-lua/plenary.nvim',
    {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update { with_sync = true } end,
    },
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/playground',
    -- :]

    -- primeagen [:
    'ThePrimeagen/harpoon',
    'ThePrimeagen/git-worktree.nvim',
    -- :]

    -- textobjects [:
    'glts/vim-textobj-comment',
    'Julian/vim-textobj-variable-segment',
    'kana/vim-textobj-entire',
    'kana/vim-textobj-fold',
    'kana/vim-textobj-indent',
    'kana/vim-textobj-user',
    'vimtaku/vim-textobj-keyvalue',
    'whatyouhide/vim-textobj-xmlattr',
    -- :]

    -- git [:
    'tpope/vim-fugitive',
    'lewis6991/gitsigns.nvim',
    -- :]

    -- aesthetic [:
    'itchyny/vim-highlighturl',
    'NvChad/nvim-colorizer.lua',
    -- :]

    -- misc [:
    'AckslD/nvim-neoclip.lua',
    'AndrewRadev/splitjoin.vim',
    'andymass/vim-matchup',
    'axelvc/template-string.nvim',
    {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
    },
    'ibhagwan/fzf-lua',
    'jeetsukumaran/vim-indentwise',
    'junegunn/vim-easy-align',
    'kyazdani42/nvim-tree.lua',
    'L3MON4D3/LuaSnip',
    'mbbill/undotree',
    'monaqa/dial.nvim',
    'numToStr/Comment.nvim',
    'ojroques/nvim-bufdel',
    'rest-nvim/rest.nvim',
    'tpope/vim-abolish',
    'tpope/vim-repeat',
    'tpope/vim-sleuth',
    'tpope/vim-surround',
    'wellle/targets.vim',
    -- :]
}

local utils = require 'utils'
local map, mapstr = utils.map, utils.mapstr

map { 'n', '<leader>Pc', mapstr 'PaqClean' }
map { 'n', '<leader>Pi', mapstr 'PaqInstall' }
map { 'n', '<leader>Pu', mapstr 'PaqUpdate' }
map { 'n', '<leader>Pl', mapstr 'PaqLogOpen' }
map { 'n', '<leader>PL', mapstr 'PaqList' }
