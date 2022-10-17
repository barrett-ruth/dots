local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local c, d, i, s, sn, t = ls.c, ls.d, ls.i, ls.s, ls.sn, ls.t

local function surroundl(args)
    if args[1][1]:len() ~= 0 and args[1][1]:find ',' then
        return sn(nil, { t { '(' } })
    end
    return sn(nil, { t '' })
end

local function surroundr(args)
    if args[1][1]:len() ~= 0 and args[1][1]:find ',' then
        return sn(nil, { t { ')' } })
    end
    return sn(nil, { t '' })
end

local javascript = {
    s(
        'af',
        fmt(
            '{}{}{} => {}',
            { d(1, surroundl, { 2 }), i(2), d(3, surroundr, { 2 }), i(4) }
        )
    ),
    s('da', fmt('[{}] = {}', { i(1), i(2) })),
    s('do', fmt('{{ {} }} = {}', { i(1), i(2) })),
    s('fun', fmt('function {}({}) {{\n\t{}\n}}', { i(1), i(2), i(3) })),
    s('im', fmt([[import {} from '{}']], { i(1), i(2) })),
    s('pr', fmt('console.log({})', { i(1) })),
    s('for', fmt('for ({}) {{\n\t{}\n}}', { i(1), i(2) })),
    s('`$', fmt('`${{{}}}`', { i(1) })),
}

ls.add_snippets('javascript', {})

return javascript
