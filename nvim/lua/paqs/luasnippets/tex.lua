local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local i, f, s = ls.i, ls.f, ls.s

local word = function(variable) return variable[1][1] end

ls.add_snippets('tex', {
    s(
        'beg',
        fmt(
            [[
                \begin{{{}}}
                    {}
                \end{{{}}}
            ]],
            { i(1), i(2), f(word, { 1 }) }
        )
    ),
    s(
        'doc',
        fmt(
            [[
                \documentclass{{{}}}
                \begin{{document}}
                    {}
                \end{{document}}
            ]],
            { i(1), i(2) }
        )
    ),
    s('item', fmt('\\item {}', { i(1) })),
    s('ul', fmt('\\underline{{{}}}', { i(1) })),
})
