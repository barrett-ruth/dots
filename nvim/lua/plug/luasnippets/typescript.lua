local ls = require 'luasnip'

local javascript = require 'plug.luasnippets.javascript'
local typescript = {}

ls.add_snippets('typescript', javascript)
ls.add_snippets('typescript', typescript)

return typescript
