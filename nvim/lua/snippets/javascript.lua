local function surround(args, _, paren)
    if args[1][1]:len() ~= 0 and args[1][1]:find ',' then
        return paren
    end

    return ''
end

return {
    s(
        'af',
        fmt('{}{}{} => {}', {
            f(surround, { 1 }, { user_args = { '(' } }),
            i(1),
            f(surround, { 1 }, { user_args = { ')' } }),
            i(2),
        })
    ),
    s('fun', fmt('function {}({}) {{\n\t{}\n}}', { i(1), i(2), i(3) })),
    s('im', fmt([[import {} from '{}']], { i(1), i(2) })),
    s('pr', fmt('console.log({})', { i(1) })),
    s('for', fmt('for ({}) {{\n\t{}\n}}', { i(1), i(2) })),
}
