local ls = require 'luasnip'

local i, s = ls.i, ls.s
local fmt = require('luasnip.extras.fmt').fmt

local javascript = require 'paqs.luasnippets.javascript'
local javascriptreact = require 'paqs.luasnippets.javascriptreact'
local tags = require 'paqs.luasnippets.html'
local typescript = require 'paqs.luasnippets.typescript'

local typescriptreact = {
    s('fc', fmt('({}){} => (\n\t{}\n)', { i(1), i(2), i(3) })),
}

ls.add_snippets('typescriptreact', typescriptreact)
ls.add_snippets('typescriptreact', javascriptreact)
ls.add_snippets('typescriptreact', typescript)
ls.add_snippets('typescriptreact', javascript)
ls.add_snippets('typescriptreact', tags)
