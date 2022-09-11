vim.wo.spell = false
vim.opt_local.statusline = nil

local utils = require 'utils'
utils.bmap { 'n', 'q', utils.mapstr 'q' }
