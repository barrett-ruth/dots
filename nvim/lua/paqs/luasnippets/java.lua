local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local i, s = ls.i, ls.s

local java = {
    s(
        'main',
        fmt(
            [[
            public class {} {{
                public static void main(String[] args) {{
                    {}
                }}
            }}
        ]],
            { i(1, (function() return vim.fn.expand '%:t:r' end)()), i(2) }
        )
    ),
    s('pr', fmt('System.out.println({});', { i(1) })),
}

ls.add_snippets('java', java)
