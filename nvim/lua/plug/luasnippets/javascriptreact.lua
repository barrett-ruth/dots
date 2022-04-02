local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local i = ls.i
local s = ls.s

local javascript = require 'plug.luasnippets.javascript'
local tags = require 'plug.luasnippets.html'

local javascriptreact = {
    s(
        '</',
        fmt(
            [[
                <{} />
            ]],
            { i(1) }
        )
    ),
}

ls.add_snippets('javascriptreact', javascript)
ls.add_snippets('javascriptreact', javascriptreact)
ls.add_snippets('javascriptreact', tags)

return javascriptreact
