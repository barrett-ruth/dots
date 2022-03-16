require('auto-session').setup {
    auto_save_enabled = true,
}

local utils = require 'utils'
local map = utils.map
local mapstr = utils.mapstr

map { 'n', '<leader>sd', mapstr 'DeleteSession' }
map { 'n', '<leader>sr', mapstr 'RestoreSession' }
map { 'n', '<leader>ss', mapstr 'SaveSession' }
