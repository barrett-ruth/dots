local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt
local i = ls.i
local s = ls.s
local t = ls.t

ls.snippets.lua = {
    s(
        'lr',
        fmt(
            [[
                local {} = require '{}'
            ]],
            { i(1), i(2) }
        )
    ),
    s('[[', {
        t '[[',
        t { '', '    ' },
        i(1),
        t { '', '' },
        t ']]',
    }),
}
