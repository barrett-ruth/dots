local ls = require 'luasnip'

local sh = require 'plug.luasnippets.sh'
local zsh = {}

ls.add_snippets('zsh', sh)
ls.add_snippets('zsh', zsh)
