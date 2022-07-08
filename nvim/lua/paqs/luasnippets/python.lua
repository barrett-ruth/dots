local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local c, i, s, t = ls.c, ls.i, ls.s, ls.t

local either = function(pos, a, b) return c(pos, { t(a), t(b) }) end

ls.add_snippets('python', {
    s(
        'def',
        fmt(
            'def {}({}){}{}:\n\t{}',
            { i(1), i(2), either(3, ' -> ', ''), i(4), i(5) }
        )
    ),
    s('pr', fmt('print({})', { i(1) })),
})
