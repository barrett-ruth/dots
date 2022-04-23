local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local i = ls.i
local f = ls.f
local s = ls.s

local lastword = function(variable)
    local parts = vim.split(variable[1][1], '.', true)
    return parts[#parts] or ''
end

ls.add_snippets('lua', {
    s('pr', fmt('print({})', { i(1) })),
    s('fu', fmt('function {}({})\n\t{}\nend', { i(1), i(2), i(3) })),
    s('if', fmt('if {} then\n\t{}\nend', { i(1), i(2) })),
    s('for', fmt('for {} in {}({}) do\n\t{}\nend', { i(1), i(2), i(3), i(4) })),
    s('lor', fmt("local {} = require '{}'", { i(1), i(2) })),
    s(
        'le',
        fmt('local {} = {}', {
            f(lastword, { 1 }),
            i(1),
        })
    ),
    s(
        'lr',
        fmt("local {} = require '{}'", {
            f(lastword, { 1 }),
            i(1),
        })
    ),
})
