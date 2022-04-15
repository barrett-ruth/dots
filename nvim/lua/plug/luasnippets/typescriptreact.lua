local ls = require 'luasnip'

local javascript = require 'plug.luasnippets.javascript'
local javascriptreact = require 'plug.luasnippets.javascriptreact'
local tags = require 'plug.luasnippets.html'
local typescript = require 'plug.luasnippets.typescript'

ls.add_snippets('typescriptreact', javascript)
ls.add_snippets('typescriptreact', javascriptreact)
ls.add_snippets('typescriptreact', typescript)
ls.add_snippets('typescriptreact', tags)
