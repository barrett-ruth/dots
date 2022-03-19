local ls = require 'luasnip'

if ls.snippets.html then
    return
end

local extras = require 'luasnip.extras'
local fmt = require('luasnip.extras.fmt').fmt
local i = ls.i
local rep = extras.rep
local s = ls.s

ls.snippets.html = {
    s(
        '<>',
        fmt(
            [[
                <{}>
                  {}
                </{}>
            ]],
            { i(1), i(2), rep(1) }
        )
    ),
    s(
        '</',
        fmt(
            [[
                <{}/>
            ]],
            { i(1) }
        )
    ),
    s(
        'bp',
        fmt(
            [[
                <!DOCTYPE html>
                <html lang="en">
                <head>
                  <meta charset="UTF-8">
                  <meta name="viewport" content="width=device-width, initial-scale=1.0">
                  <title>{}</title>
                </head>
                <body>
                  {}
                </body>
                </html>
            ]],
            { i(1), i(2) }
        )
    ),
}
