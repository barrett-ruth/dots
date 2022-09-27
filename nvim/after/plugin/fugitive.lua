local utils = require 'utils'
local bmap, mapstr = utils.bmap, utils.mapstr

bmap { 'n', '<leader>vv', mapstr 'G' }
bmap { 'n', '<leader>vd', mapstr 'Gvdiffsplit!' }
bmap { 'n', '<leader>vf', mapstr 'G fetch' }
bmap { 'n', '<leader>vp', mapstr 'G pull' }
bmap { 'n', '<leader>vP', mapstr 'G push' }
bmap { 'n', '<leader>vs', mapstr 'G status' }
bmap { 'n', '<leader>v2', mapstr 'diffget //2' }
bmap { 'n', '<leader>v3', mapstr 'diffget //3' }
bmap { 'n', '<leader>vl', mapstr 'G log' }
