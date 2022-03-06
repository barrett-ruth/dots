local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt
local i = ls.i
local s = ls.s

local M = {
    s('pr', fmt([[ console.log({}) ]], { i(1) })),
}

ls.snippets.javascript = M

return M
