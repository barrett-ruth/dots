require('auto-session').setup {
    auto_save_enabled = true,
}

local utils = require 'utils'
local map = utils.map
local mapstr = utils.mapstr

local sessionleader = '<leader>s'
map { 'n', sessionleader .. 'd', mapstr 'DeleteSession' }
map { 'n', sessionleader .. 'r', mapstr 'RestoreSession' }
map { 'n', sessionleader .. 's', mapstr 'SaveSession' }
