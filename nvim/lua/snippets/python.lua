local function class_assign_args(args)
    local arg = args[1][1]

    if arg:len() == 0 then return sn(nil, { t { '', '\t\t' } }) end

    local assign_args = {}
    for e in arg:gmatch ' ?([^,]*): ?' do
        if e:len() > 0 then
            e = e:sub(1, require('utils').rfind(e, ':') or #e)
            table.insert(
                assign_args,
                t { '', ('\t\tself.%s = %s'):format(e, e) }
            )
        end
    end

    return sn(nil, assign_args)
end

return {
    s(
        'main',
        fmt(
            "def main() -> None:\n\t{}\n\n\nif __name__ == '__main__':\n\tmain()",
            { i(1) }
        )
    ),
    s('im', fmt([[from {} import {}]], { i(1), i(2) })),
    s('def', fmt('def {}({}) -> {}:\n\t{}', { i(1), i(2), i(3), i(4) })),
    s('pr', fmt('print({})', { i(1) })),
    s(
        'class',
        fmt(
            [[
                class {}:
                    def __init__(self, {}):{}
            ]],
            { i(1), i(2), d(3, class_assign_args, { 2 }) }
        )
    ),
}
