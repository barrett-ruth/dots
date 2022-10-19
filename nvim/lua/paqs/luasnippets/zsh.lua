local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local i, s = ls.i, ls.s

local sh = require 'paqs.luasnippets.sh'
local zsh = {
    s('&', fmt('[[ {} ]] && {}', { i(1), i(2) })),
    s('|', fmt('[[ {} ]] || {}', { i(1), i(2) })),
    s('if', fmt('if [[ {} ]]; then\n\t{}\nfi', { i(1), i(2) })),
}

ls.add_snippets('zsh', zsh)
ls.add_snippets('zsh', sh)
