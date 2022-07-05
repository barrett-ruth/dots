vim.wo.spell = false
vim.wo.statusline = [[%{%v:lua.require'statusline'.statusline()%}]]

local utils = require 'utils'
utils.bmap { 'n', 'q', utils.mapstr 'q' }
