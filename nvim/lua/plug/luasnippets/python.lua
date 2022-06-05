local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local i, s = ls.i, ls.s

ls.add_snippets('python', {
    s('pr', fmt('print({})', { i(1) })),
})
