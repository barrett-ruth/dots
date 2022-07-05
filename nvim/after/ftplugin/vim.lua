vim.bo.keywordprg = ':help'

local utils = require 'utils'
local cs, hi = utils.cs, utils.hi

hi('vimTSVariableBuiltin', { fg = cs.purple })
