vim.wo.signcolumn = 'no'

local utils = require 'utils'

utils.bmap { 'n', 'q', utils.mapstr 'q' }
