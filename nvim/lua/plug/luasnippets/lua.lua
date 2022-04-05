local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local i = ls.i
local f = ls.f
local s = ls.s

ls.add_snippets('lua', {
    s('pr', fmt('print({})', { i(1) })),
    s('[[', fmt('[[{}]]', { i(1) })),
    s(']]', fmt('[[\n\t{}\n]]', { i(1) })),
    s('fun', fmt('function {}({})\n\t{}\nend', { i(1), i(2), i(3) })),
    s('if', fmt('if {} then\n\t{}\nend', { i(1), i(2) })),
    s('for', fmt('for {} in {}({}) do\n\t{}\nend', { i(1), i(2), i(3), i(4) })),
    s('lor', fmt("local {} = require '{}'", { i(1), i(2) })),
    s(
        'lr',
        fmt("local {} = require '{}'", {
            f(function(import)
                local parts = vim.split(import[1][1], '.', true)
                return parts[#parts] or ''
            end, { 1 }),
            i(1),
        })
    ),
})
