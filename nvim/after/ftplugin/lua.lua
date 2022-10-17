local utils = require 'utils'
local cs, hi, link = utils.cs, utils.hi, utils.link

hi('luaConstructor', { fg = cs.white })
hi('luaConstBuiltin', { fg = cs.purple })
hi('luaFunction', { italic = true, fg = cs.red })
link('@function', 'luaFunc')
hi('luaIn', { italic = true, fg = cs.red })
