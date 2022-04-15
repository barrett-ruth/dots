local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local c = ls.choice_node
local i = ls.i
local s = ls.s
local t = ls.t

local either = function(pos, a, b)
    return c(pos, { t(a), t(b) })
end

local javascript = {
    s('afu', fmt('{} => {}', { i(1), i(2) })),
    s('afun', fmt('({}) => {{\n\t{}\n}}', { i(1), i(2) })),
    s('dea', fmt('{} [{}] = {}', { either(1, 'const', 'let'), i(2), i(3) })),
    s('deo', fmt('{} {{ {} }} = {}', { either(1, 'const', 'let'), i(2), i(3) })),
    s('fun', fmt('function {}({}) {{\n\t{}\n}}', { i(1), i(2), i(3) })),
    s('imp', fmt("import {} from '{}'", { i(1), i(2) })),
    s('pr', fmt('console.log({})', { i(1) })),
    s('foi', fmt('for ({} {} in {}) {{\n\t{}\n}}', { either(1, 'const', 'let'), i(2), i(3), i(4) })),
    s('fof', fmt('for ({} {} of {}) {{\n\t{}\n}}', { either(1, 'const', 'let'), i(2), i(3), i(4) })),
    s('for', fmt('for ({}) {{\n\t{}\n}}', { i(1), i(2) })),
}

ls.add_snippets('javascript', javascript)

return javascript
