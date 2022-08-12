local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local i, s = ls.i, ls.s

ls.add_snippets('tex', {
    s(
        'doc',
        fmt(
            [[
                \documentclass{{article}}
                \begin{{document}}
                    {}
                \end{{document}}
            ]],
            { i(1) }
        )
    ),
    s('item', fmt('\\item {}', { i(1) })),
    s(
        'itemize',
        fmt(
            [[
                \begin{{itemize}}
                    {}
                \end{{itemize}}
            ]],
            { i(1) }
        )
    ),
    s(
        'sec',
        fmt(
            [[
                \begin{{section}}
                    {}
                \end{{section}}
            ]],
            { i(1) }
        )
    ),
    s(
        'subsec',
        fmt(
            [[
                \begin{{subsection}}
                    {}
                \end{{subsection}}
            ]],
            { i(1) }
        )
    ),
    s('ul', fmt('\\underline{{{}}}', { i(1) })),
})
