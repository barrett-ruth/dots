return {
    s('ue', fmt('useEffect(() => {{\n\t{}\n}}{})', { i(1), i(2) })),
    s('um', fmt('useMemo(() => {})', { i(1) })),
    s(
        'us',
        fmt('const [{}, {}] = useState({})', {
            i(1),
            f(function(state)
                return 'set' .. state[1][1]:gsub('^%l', string.upper)
            end, { 1 }),
            i(2),
        })
    ),
}
