return {
    s(
        'main',
        fmt(
            [[
                def main() -> None:
                    {}


                if __name__ == '__main__':
                    main()
            ]],
            { i(1) }
        )
    ),
    s('f', fmt('print(f{}{}{})', { c(1, { t("'"), t('"') }), i(2), rep(1) })),
}
