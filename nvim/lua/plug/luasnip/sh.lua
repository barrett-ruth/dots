local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt
local i = ls.i
local s = ls.s

ls.snippets.sh = {
    s(
        '&&',
        fmt(
            [[
                [ {} ] && {}
            ]],
            { i(1), i(2) }
        )
    ),
    s(
        '||',
        fmt(
            [[
                [ {} ] || {}
            ]],
            { i(1), i(2) }
        )
    ),
    s(
        'case',
        fmt(
            [[
                case "${}" in
                {})
                    {}
                    ;;
                esac
            ]],
            { i(1), i(2), i(3) }
        )
    ),
    s(
        'if',
        fmt(
            [[
                if [ {} ]; then
                    {}
                fi
            ]],
            { i(1), i(2) }
        )
    ),
    s(
        'ife',
        fmt(
            [[
                if [ {} ]; then
                    {}
                else
                    {}
                fi
            ]],
            { i(1), i(2), i(3) }
        )
    ),
    s(
        'for',
        fmt(
            [[
                for {} in {}; do
                    {}
                done
            ]],
            { i(1), i(2), i(3) }
        )
    ),
    s(
        'while',
        fmt(
            [[
                while {} in {}; do
                    {}
                done
            ]],
            { i(1), i(2), i(3) }
        )
    ),
    s(
        's',
        fmt(
            [[
                "$({})"
            ]],
            { i(1) }
        )
    ),
    s(
        'v',
        fmt(
            [[
                "${}"
            ]],
            { i(1) }
        )
    ),
}
