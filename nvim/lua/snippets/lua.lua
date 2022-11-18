local utils = require 'utils'

local extract_vars = function(args)
    local vars = {}

    for _, e in ipairs(vim.split(args[1][1], ', ', { trimempty = true })) do
        if e:len() > 0 then
            local var = e

            if var:match '%.' then
                var = var:sub(utils.rfind(var, '%.'))

                if var:match "'" then
                    var = var:sub(1, utils.rfind(var, "'") - 1)
                end

                if var:match '%.' then
                    var = var:sub(2)
                end
            else
                var = var:match "'([^)]+)'"
            end

            table.insert(vars, var)
        end
    end

    return table.concat(vars, ', ')
end

return {
    s('pr', fmt('vim.pretty_print({})', { i(1) })),
    s('af', fmt('function({}) {} end', { i(1), i(2) })),
    s('fun', fmt('function({})\n\t{}\nend', { i(1), i(2) })),
    s('if', fmt('if {} then\n\t{}\nend', { i(1), i(2) })),
    s('for', fmt('for {} in {} do\n\t{}\nend', { i(1), i(2), i(3) })),
    s(
        'lo',
        fmt('local {} = {}', {
            f(extract_vars, { 1 }),
            i(1),
        })
    ),
}
