local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local i, s = ls.i, ls.s

local sh = {
    s('&', fmt('[ {} ] && {}', { i(1), i(2) })),
    s('s', fmt('"$({})"', { i(1) })),
    s('v', fmt('"${}"', { i(1) })),
    s('|', fmt('[ {} ] || {}', { i(1), i(2) })),
    s('case', fmt('case "${}" in\n{})\n\t{}\n\t;;\nesac', { i(1), i(2), i(3) })),
    s('if', fmt('if [ {} ]; then\n\t{}\nfi', { i(1), i(2) })),
    s('for', fmt('for {} in {}; do\n\t{}\ndone', { i(1), i(2), i(3) })),
    s('while', fmt('while {}; do\n\t{}\ndone ', { i(1), i(2) })),
}

ls.add_snippets('sh', sh)

return sh
