require('auto-session').setup {
    auto_save_enabled = true,
}

local utils = require 'utils'
local map = utils.map
local mapstr = utils.mapstr

map { 'n', '<leader>sd', mapstr 'sil DeleteSession' .. mapstr "echo 'Session deleted.'" }
map { 'n', '<leader>sr', mapstr 'sil RestoreSession' .. mapstr "echo 'Session restored.'" }
map { 'n', '<leader>ss', mapstr 'sil SaveSession' .. mapstr "echo 'Session saved.'" }
