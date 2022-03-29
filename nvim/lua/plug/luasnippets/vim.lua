local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local i = ls.i
local s = ls.s

ls.add_snippets('vim', {
    s(
        'aug',
        fmt(
            [[
                aug {}
                    {}
                aug end
            ]],
            { i(1), i(2) }
        )
    ),
})
