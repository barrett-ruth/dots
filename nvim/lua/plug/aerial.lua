require('aerial').setup {
    width = 0.4,
    manage_folds = true,
    link_folds_to_tree = true,
}

local utils = require 'utils'
local map = utils.map
local mapstr = utils.mapstr

map { 'n', '<leader>a', mapstr 'AerialToggle' }

local aerialleader = vim.g.mapleader .. 'A'
map { 'n', aerialleader .. 't', mapstr 'AerialTreeToggle' }
