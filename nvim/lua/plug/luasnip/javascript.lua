local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt
local i = ls.i
local s = ls.s
local t = ls.t

local M = {
    s('pr', fmt([[ console.log({}) ]], { i(1) })),
    s('afu', {
        i(1),
        t ' => ',
        i(2),
    }),
    s('afun', {
        t '(',
        i(1),
        t ') => {',
        t { '', '    ' },
        i(2),
        t { '', '}' },
    }),
}

ls.snippets.javascript = M

return M
