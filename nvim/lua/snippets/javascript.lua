local function surround(args, char)
    if args[1][1]:len() ~= 0 and args[1][1]:find ',' then
        return sn(nil, { t { char } })
    end

    return sn(nil, { t '' })
end

return {
    s(
        'af',
        fmt('{}{}{} => {}', {
            d(1, function(...) surround(..., '(') end, { 2 }),
            i(2),
            d(3, function(...) surround(..., ')') end, { 2 }),
            i(4),
        })
    ),
    s('da', fmt('[{}] = {}', { i(1), i(2) })),
    s('do', fmt('{{ {} }} = {}', { i(1), i(2) })),
    s('fun', fmt('function {}({}) {{\n\t{}\n}}', { i(1), i(2), i(3) })),
    s('im', fmt([[import {} from '{}']], { i(1), i(2) })),
    s('pr', fmt('console.log({})', { i(1) })),
    s('for', fmt('for ({}) {{\n\t{}\n}}', { i(1), i(2) })),
}
