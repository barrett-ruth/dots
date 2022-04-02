local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local i = ls.i
local f = ls.f
local s = ls.s
local t = ls.t

ls.add_snippets('lua', {
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
        'ipairs',
        fmt(
            [[
                for {}, {} in ipairs({}) do
                    {}
                end
            ]],
            { i(1, '_'), i(2, 'v'), i(3), i(4) }
        )
    ),
    s(
        'lor',
        fmt(
            [[
                local {} = require '{}'
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
            {
                f(function(import)
                    local parts = vim.split(import[1][1], '.', true)
                    return parts[#parts] or ''
                end, { 1 }),
                i(1),
            }
        )
    ),
    s(
        'pairs',
        fmt(
            [[
                for {}, {} in pairs({}) do
                    {}
                end
            ]],
            { i(1, 'k'), i(2, 'v'), i(3), i(4) }
        )
    ),
    s(
        'pr',
        fmt(
            [[
                print({})
            ]],
            { i(1) }
        )
    ),
    s('[[', {
        t '[[',
        t { '', '\t' },
        i(1),
        t { '', '' },
        t ']]',
    }),
})
