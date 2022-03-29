local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local c = ls.choice_node
local d = ls.dynamic_node
local i = ls.i
local s = ls.s
local sn = ls.sn
local t = ls.t

local either = function(pos, a, b)
    return d(pos, function()
        return sn(nil, c(1, { t(a), t(b) }))
    end, {})
end

local javascript = {
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
    s(
        'fof',
        fmt(
            [[
                for ({} {} of {}) {{
                    {}
                }}
            ]],
            { either(1, 'let', 'const'), i(2), i(3), i(4) }
        )
    ),
    s(
        'for',
        fmt(
            [[
                for ({} {} {} {}) {{
                    {}
                }}
            ]],
            { either(1, 'let', 'const'), i(2), either(3, 'of', 'in'), i(4), i(5) }
        )
    ),
    s(
        'foi',
        fmt(
            [[
                for ({}; {}; {}) {{
                    {}
                }}
            ]],
            { i(1), i(2), i(3), i(4) }
        )
    ),
}

ls.add_snippets('javascript', javascript)

return javascript
