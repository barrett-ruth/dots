local utils = require 'utils'
local cs, hi, link = utils.cs, utils.hi, utils.link

hi('luaTSConstructor', { fg = cs.white })
hi('luaTSConstBuiltin', { fg = cs.purple })
hi('luaFunction', { italic = true, fg = cs.red })
link('TSFunction', 'luaFunc')
hi('luaIn', { italic = true, fg = cs.red })
