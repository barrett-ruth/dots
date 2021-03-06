local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local i, s = ls.i, ls.s

ls.add_snippets('vim', {
    s('aug', fmt('aug {}\n\t{}\n aug end', { i(1), i(2) })),
    s('fun', fmt('function {}({})\n\t{}\nendf', { i(1), i(2), i(3) })),
})
