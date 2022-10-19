local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local i, f, s = ls.i, ls.f, ls.s

local word = function(index)
    return f(function(name) return vim.split(name[1][1], ' ')[1] end, { index })
end

local tags = {
    s('</', fmt('<{} />', { i(1) })),
    s('<<', fmt('<{}>{}</{}>', { i(1), i(2), word(1) })),
    s('<>', fmt('<{}>\n\t{}\n</{}>', { i(1), i(2), word(1) })),
}

ls.add_snippets('html', tags)
ls.add_snippets('html', {
    s(
        'bp',
        fmt(
            [[
                <!DOCTYPE html>
                <html lang="en">
                  <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1" />
                    <title>{}</title>
                  </head>
                </html>
            ]],
            { i(1) }
        )
    ),
})

return tags
