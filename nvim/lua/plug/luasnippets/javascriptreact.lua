local ls = require 'luasnip'

local c = ls.c
local i = ls.i
local f = ls.f
local fmt = require('luasnip.extras.fmt').fmt
local s = ls.s
local t = ls.t

local javascript = require 'plug.luasnippets.javascript'
local tags = require 'plug.luasnippets.html'

local either = function(pos, a, b)
    return c(pos, { t(a), t(b) })
end

local javascriptreact = {
    s('ue', fmt('useEffect(() => {{\n\t{}\n}}{})', { i(1), i(2) })),
    s('um', fmt('{} {} = useMemo(() => {})', { either(1, 'const', 'let'), i(2), i(3) })),
    s('um', fmt('{} {} = useRef({})', { either(1, 'const', 'let'), i(2), i(3) })),
    s('ur', fmt('{} [{}, {}] = useReducer({}, {})', { either(1, 'const', 'let'), i(2), i(3), i(4), i(5) })),
    s(
        'us',
        fmt('const [{}, {}] = useState({});', {
            i(1),
            f(function(state)
                return 'set' .. state[1][1]:gsub('^%l', string.upper)
            end, { 1 }),
            i(2),
        })
    ),
}

ls.add_snippets('javascriptreact', javascript)
ls.add_snippets('javascriptreact', javascriptreact)
ls.add_snippets('javascriptreact', tags)

return javascriptreact
