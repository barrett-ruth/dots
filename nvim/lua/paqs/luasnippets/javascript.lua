local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local c, i, s, t = ls.choice_node, ls.i, ls.s, ls.t

local either = function(pos, a, b) return c(pos, { t(a), t(b) }) end

local javascript = {
    s('af', fmt('({}) => {}', { i(1), i(2) })),
    s('da', fmt('[{}] = {}', { i(1), i(2) })),
    s('do', fmt('{{ {} }} = {}', { i(1), i(2) })),
    s('fun', fmt('function {}({}) {{\n\t{}\n}}', { i(1), i(2), i(3) })),
    s('im', fmt([[import {} from '{}']], { i(1), i(2) })),
    s('pr', fmt('console.log({})', { i(1) })),
    s(
        'foi',
        fmt(
            'for ({} {} in {}) {{\n\t{}\n}}',
            { either(1, 'const', 'let'), i(2), i(3), i(4) }
        )
    ),
    s(
        'foo',
        fmt(
            'for ({} {} of {}) {{\n\t{}\n}}',
            { either(1, 'const', 'let'), i(2), i(3), i(4) }
        )
    ),
    s('for', fmt('for ({}) {{\n\t{}\n}}', { i(1), i(2) })),
}

ls.add_snippets('javascript', javascript)

return javascript
