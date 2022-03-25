local ls = require 'luasnip'

if ls.snippets.javascript then
    return
end

local fmt = require('luasnip.extras.fmt').fmt
local c = ls.choice_node
local d = ls.dynamic_node
local i = ls.i
local rep = require('luasnip.extras').rep
local s = ls.s
local sn = ls.sn
local t = ls.t

local let_or_const = function(pos)
    return d(pos, function()
        return sn(nil, c(1, { t 'let', t 'const' }))
    end, {})
end

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
    s(
        'fof',
        fmt(
            [[
                for ({} {} of {}) {{
                    {}
                }}
            ]],
            { let_or_const(1), i(2), i(3), i(4) }
        )
    ),
    s(
        'fin',
        fmt(
            [[
                for ({} {} in {}) {{
                    {}
                }}
            ]],
            { let_or_const(1), i(2), i(3), i(4) }
        )
    ),
    s(
        'for',
        fmt(
            [[
                for ({} {} = {}; {} < {}; {}++) {{
                    {}
                }}
            ]],
            { let_or_const(1), i(2), i(3, '0'), rep(2), i(4), rep(2), i(5) }
        )
    ),
}

ls.snippets.javascript = javascript

return javascript
