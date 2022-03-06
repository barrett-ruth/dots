local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt
local i = ls.i
local s = ls.s
local t = ls.t

ls.snippets.lua = {
    s(
        'pr',
        fmt(
            [[
                print({})
            ]],
            { i(1) }
        )
    ),
    s(
        'fun',
        fmt(
            [[
                function {}({})
                    {}
                end
            ]],
            { i(1), i(2), i(3) }
        )
    ),
    s(
        'lfun',
        fmt(
            [[
                local {} = function({})
                    {}
                end
            ]],
            { i(1), i(2), i(3) }
        )
    ),
    s(
        'if',
        fmt(
            [[
                if {} then
                    {}
                end
            ]],
            { i(1), i(2) }
        )
    ),
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
