local ls = require 'luasnip'

if ls.snippets.typescriptreact then
    return
end

local javascript = require 'plug.luasnip.javascript'

local typescriptreact = javascript

ls.snippets.typescriptreact = typescriptreact
