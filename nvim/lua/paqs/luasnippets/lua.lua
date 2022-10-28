local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local i, f, s = ls.i, ls.f, ls.s

local extract_vars = function(args)
    local vars = {}

    for _, e in ipairs(vim.split(args[1][1], ', ', { trimempty = true })) do
        if e:len() > 0 then
            local var = e

            var = var:match '[^.]+$' or var
            var = var:match "'([^']*)'" or var
            if var:sub(-1) == "'" then var = var:sub(1, -2) end

            table.insert(vars, var)
        end
    end

    return table.concat(vars, ', ')
end

ls.add_snippets('lua', {
    s('pr', fmt('print({})', { i(1) })),
    s('af', fmt('function({}) {} end', { i(1), i(2) })),
    s('afu', fmt('function({})\n\t{}\nend', { i(1), i(2) })),
    s('fun', fmt('function {}({})\n\t{}\nend', { i(1), i(2), i(3) })),
    s('if', fmt('if {} then\n\t{}\nend', { i(1), i(2) })),
    s('for', fmt('for {} in {} do\n\t{}\nend', { i(1), i(2), i(3) })),
    s(
        'lo',
        fmt('local {} = {}', {
            f(extract_vars, { 1 }),
            i(1),
        })
    ),
})
