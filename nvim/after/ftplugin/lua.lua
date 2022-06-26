local utils = require('utils')
local cs, hi = utils.cs, utils.hi

hi('TSLocal', { fg = cs.red })
hi('luaTSConstructor', { fg = cs.white })
hi('luaTSConstBuiltin', { fg = cs.purple })
hi('luaFunction', { italic = true, fg = cs.red })
hi('luaFunc', { fg = cs.green })
hi('luaIn', { italic = true, fg = cs.red })
