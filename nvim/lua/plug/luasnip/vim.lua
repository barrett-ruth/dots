local ls = require 'luasnip'

if ls.snippets.vim then
    return
end

local fmt = require('luasnip.extras.fmt').fmt
local i = ls.i
local s = ls.s

ls.snippets.vim = {
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
}
