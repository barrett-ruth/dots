local ls = require 'luasnip'

local i = ls.i
local fmt = require('luasnip.extras.fmt').fmt
local s = ls.s

local javascript = require 'plug.luasnippets.javascript'
local javascriptreact = require 'plug.luasnippets.javascriptreact'
local tags = require 'plug.luasnippets.html'
local typescript = require 'plug.luasnippets.typescript'

local typescriptreact = {
    s('fc', fmt('({}){} => (\n\t{}\n)', { i(1), i(2), i(3) })),
}

ls.add_snippets('typescriptreact', typescriptreact)
ls.add_snippets('typescriptreact', javascriptreact)
ls.add_snippets('typescriptreact', typescript)
ls.add_snippets('typescriptreact', javascript)
ls.add_snippets('typescriptreact', tags)
