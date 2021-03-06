local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local i, s = ls.i, ls.s

local c = require 'paqs.luasnippets.c'
local cpp = {
    s('pr', fmt('std::cout << {}', { i(1) })),
}

ls.add_snippets('cpp', cpp)
ls.add_snippets('cpp', c)
