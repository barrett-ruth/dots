local ls = require 'luasnip'

if ls.snippets.lua then
    return
end

local fmt = require('luasnip.extras.fmt').fmt
local i = ls.i
local f = ls.f
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
        'mfun',
        fmt(
            [[
                function M.{}({})
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
            {
                f(function(import)
                    local parts = vim.split(import[1][1], '.', true)
                    return parts[#parts] or ''
                end, { 1 }),
                i(1),
            }
        )
    ),
    s('[[', {
        t '[[',
        t { '', '\t' },
        i(1),
        t { '', '' },
        t ']]',
    }),
}
