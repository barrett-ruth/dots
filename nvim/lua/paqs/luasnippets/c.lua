local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local i, s = ls.i, ls.s

local c = {
    s('inh', fmt('#include "{}"', { i(1) })),
    s('in', fmt('#include <{}>', { i(1) })),
}

ls.add_snippets('c', c)

return c
