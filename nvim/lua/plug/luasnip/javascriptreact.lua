local ls = require 'luasnip'

if ls.snippets.javascriptreact then
    return
end

local javascript = require 'plug.luasnip.javascript'

local javascriptreact = javascript

ls.snippets.javascriptreact = javascriptreact
