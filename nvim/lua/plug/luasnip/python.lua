local ls = require 'luasnip'

if ls.snippets.python then
    return
end

local fmt = require('luasnip.extras.fmt').fmt
local i = ls.i
local s = ls.s

ls.snippets.python = {
    s('pr', fmt([[print({})]], { i(1) })),
}
