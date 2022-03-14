require('aerial').setup {
    width = 0.4,
    manage_folds = true,
    link_folds_to_tree = true,
    highlight_on_jump = false,
    post_jump_cmd = 'norm! zz',
}

local utils = require 'utils'
local map = utils.map
local mapstr = utils.mapstr

map { 'n', '<leader>a', mapstr 'AerialToggle' }
