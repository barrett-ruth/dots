vim.wo.signcolumn = 'no'

local utils = require 'utils'

utils.map { 'n', 'q', utils.mapstr 'q' }
