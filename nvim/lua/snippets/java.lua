return {
    s('/* ', fmt('/* {} */', { i(1) })),
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
            {
                i(
                    1,
                    (function()
                        return vim.fn.expand '%:t:r'
                    end)()
                ),
                i(2),
            }
        )
    ),
    s('pr', fmt('System.out.println({});', { i(1) })),
}
