vim.bo.keywordprg = ':help'

local gruvbox = require 'gruvbox'
local cs, hi = gruvbox.cs, gruvbox.hi

hi('vimVariableBuiltin', { fg = cs.purple })
