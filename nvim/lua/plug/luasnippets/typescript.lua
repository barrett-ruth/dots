local ls = require 'luasnip'

local javascript = require 'plug.luasnippets.javascript'
local typescript = {}

ls.add_snippets('typescript', typescript)
ls.add_snippets('typescript', javascript)

return typescript
