local function assign_args(args)
    local arg = args[1][1]

    if #arg == 0 then
        return sn(nil, { t({ '', '\t\t' }) })
    end

    local out = {}

    for e in arg:gmatch(' ?([^,]*)') do
        if e:len() > 0 and not e:match(']') then
            local var = e:gsub(':.*', '')
            out[#out + 1] = t({ '', ('\t\tself.%s = %s'):format(var, var) })
        end
    end

    return sn(nil, out)
end

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
    s('pr', fmt('print({})', { i(1) })),
    s(
        'class',
        fmt(
            [[
                class {}:
                    def __init__(self, {}):{}
            ]],
            { i(1), i(2), d(3, assign_args, { 2 }) }
        )
    ),
}
