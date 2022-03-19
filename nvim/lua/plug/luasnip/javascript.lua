local ls = require 'luasnip'

if ls.snippets.javascript then
    return
end

local fmt = require('luasnip.extras.fmt').fmt
local i = ls.i
local s = ls.s

local javascript = {
    s('afu', fmt([[{} => {}]], { i(1), i(2) })),
    s(
        'afun',
        fmt(
            [[
                ({}) => {{
                    {}
                }}
            ]],
            { i(1), i(2) }
        )
    ),
    s('imp', fmt([[import {} from '{}']], { i(1), i(2) })),
    s('pr', fmt([[console.log({})]], { i(1) })),
}

ls.snippets.javascript = javascript

return javascript
