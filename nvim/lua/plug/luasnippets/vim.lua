local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local i = ls.i
local s = ls.s

ls.add_snippets('vim', {
    s('aug', fmt('aug {}\n\t{}\n aug end', { i(1), i(2) })),
})
