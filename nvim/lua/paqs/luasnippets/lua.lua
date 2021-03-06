local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local i, f, s = ls.i, ls.f, ls.s

local lastword = function(variable)
    local parts = vim.split(variable[1][1], '.', true)
    return parts[#parts] or ''
end

ls.add_snippets('lua', {
    s('pr', fmt('print({})', { i(1) })),
    s('afun', fmt('function({})\n\t{}\nend', { i(1), i(2) })),
    s('fun', fmt('function {}({})\n\t{}\nend', { i(1), i(2), i(3) })),
    s('if', fmt('if {} then\n\t{}\nend', { i(1), i(2) })),
    s('for', fmt('for {} in {} do\n\t{}\nend', { i(1), i(2), i(3) })),
    s('le', fmt('local {} = {}', { i(1), i(2) })),
    s(
        'lo',
        fmt('local {} = {}', {
            f(lastword, { 1 }),
            i(1),
        })
    ),
    s(
        'lr',
        fmt([[local {} = require '{}']], {
            f(lastword, { 1 }),
            i(1),
        })
    ),
})
