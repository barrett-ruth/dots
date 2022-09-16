local utils = require 'utils'
local cs, hi, link = utils.cs, utils.hi, utils.link

hi('bashTSPunctSpecial', { fg = cs.purple })
link('TSVariable', 'shVariable')
link('TSString', 'shQuote')
link('Normal', 'shRange')
link('Operator', 'shVarAssign')
link('Operator', 'shTestOpr')
