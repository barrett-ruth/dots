local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local i, s = ls.i, ls.s

local md = {
    s('url', fmt('[{}]({})', { i(1), i(2) })),
}

ls.add_snippets('markdown', md)
