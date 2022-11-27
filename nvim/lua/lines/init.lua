local winbar = require 'lines.winbar'
local format_components = require('lines.utils').format_components

return {
    setup = function()
        vim.api.nvim_create_autocmd('FileType', {
            pattern = '*',
            callback = function()
                if
                    vim.tbl_contains({ '', 'fugitive', 'gitcommit', 'checkhealth', 'TelescopeResults' }, vim.bo.ft)
                then
                    return
                end

                vim.opt_local.winbar = format_components(winbar)
            end,
            group = vim.api.nvim_create_augroup('winbar', {}),
        })
        vim.o.statusline = [[%{%v:lua.require('lines.statusline').statusline()%}]]
    end
}
