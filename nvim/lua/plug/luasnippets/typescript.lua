local ls = require 'luasnip'

local javascript = require 'plug.luasnippets.javascript'

local typescript = javascript

ls.add_snippets('typescript', typescript)
