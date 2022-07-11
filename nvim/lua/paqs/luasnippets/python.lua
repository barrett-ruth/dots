local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local i, s = ls.i, ls.s

ls.add_snippets('python', {
    s('im', fmt([[from {} import {}]], { i(1), i(2) })),
    s('def', fmt('def {}({}) -> {}:\n\t{}', { i(1), i(2), i(3), i(4) })),
    s('pr', fmt('print({})', { i(1) })),
})
