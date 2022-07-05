vim.wo.spell = false
vim.cmd 'setl stl='

local utils = require 'utils'
utils.bmap { 'n', 'q', utils.mapstr 'q' }
