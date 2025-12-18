return {
    setup = function()
        vim.o.statusline =
            [[%{%v:lua.require('lines.statusline').statusline()%}]]
        vim.o.statuscolumn =
            [[%{%v:lua.require('lines.statuscolumn').statuscolumn()%}]]

        vim.api.nvim_create_autocmd('ColorScheme', {
            callback = function()
                vim.o.statusline =
                    [[%{%v:lua.require('lines.statusline').statusline()%}]]
                vim.o.statuscolumn =
                    [[%{%v:lua.require('lines.statuscolumn').statuscolumn()%}]]
            end,
            group = vim.api.nvim_create_augroup(
                'StatusLineInit',
                { clear = true }
            ),
        })
    end,
}
