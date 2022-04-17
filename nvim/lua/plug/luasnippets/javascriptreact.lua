local ls = require 'luasnip'

local i = ls.i
local f = ls.f
local fmt = require('luasnip.extras.fmt').fmt
local s = ls.s

local javascript = require 'plug.luasnippets.javascript'
local tags = require 'plug.luasnippets.html'

local javascriptreact = {
    s('fc', fmt('({}) => (\n\t{}\n)', { i(1), i(2) })),
    s('ue', fmt('useEffect(() => {{\n\t{}\n}}{})', { i(1), i(2) })),
    s('um', fmt('useMemo(() => {})', { i(1) })),
    s('um', fmt('useRef({})', { i(1) })),
    s('ur', fmt('useReducer({}, {})', { i(1), i(2) })),
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
