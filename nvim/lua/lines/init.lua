local utils = require('utils')

return {
    setup = function()
        vim.o.statusline =
            [[%{%v:lua.require('lines.statusline').statusline()%}]]
        vim.o.statuscolumn =
            [[%{%v:lua.require('lines.statuscolumn').statuscolumn()%}]]

        utils.au('ColorScheme', 'StatusLineInit', {
            pattern = '*',
            callback = function()
                vim.o.statusline =
                    [[%{%v:lua.require('lines.statusline').statusline()%}]]
                vim.o.statuscolumn =
                    [[%{%v:lua.require('lines.statuscolumn').statuscolumn()%}]]
            end,
        })
    end,
}
