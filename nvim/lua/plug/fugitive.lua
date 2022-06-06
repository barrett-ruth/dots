local utils = require 'utils'
local map, mapstr = utils.map, utils.mapstr

-- Fugitive
map { 'n', '<leader>vd', mapstr 'G d' }
map { 'n', '<leader>vf', mapstr 'G fetch' }
map { 'n', '<leader>vp', mapstr 'G pull' }
map { 'n', '<leader>vP', mapstr 'G push' }
map { 'n', '<leader>vs', mapstr 'G status' }
map { 'n', '<leader>vS', mapstr 'G stash' }
map { 'n', '<leader>v2', mapstr 'diffget //2' }
map { 'n', '<leader>v3', mapstr 'diffget //3' }
map { 'n', '<leader>vl', mapstr 'G log' }
map { 'n', '<leader>vL', mapstr 'G lg' }
