local components = require 'lines.winbar.components'

local format_components = require('lines.utils').format_components

local api, fn = vim.api, vim.fn

return {
    set_unfocused_winbars = function()
        for _, buf in ipairs(fn.getbufinfo { buflisted = 1 }) do
            if
                fn.bufwinid(buf.bufnr) ~= -1
                and not vim.tbl_contains(
                    { '', 'run' },
                    api.nvim_buf_get_option(buf.bufnr, 'filetype')
                )
            then
                api.nvim_win_set_option(
                    fn.bufwinid(buf.bufnr),
                    'winbar',
                    [[%{%v:lua.require('lines.winbar').winbar()%}]]
                )
            end
        end
    end,
    winbar = function()
        return ' ' .. format_components(components)
    end,
}
