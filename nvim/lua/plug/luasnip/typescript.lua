local ls = require 'luasnip'

if ls.snippets.typescript then
    return
end

local javascript = require 'plug.luasnip.javascript'

local typescript = javascript

ls.snippets.typescript = typescript
