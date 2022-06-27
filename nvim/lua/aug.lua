local au = vim.api.nvim_create_autocmd
local aug = vim.api.nvim_create_augroup('augs', { clear = true })

local utils = require 'utils'

au('BufEnter', {
    pattern = 'PKGBUILD',
    command = 'se filetype=PKGBUILD',
    group = aug,
})

au('InsertEnter', {
    command = 'se colorcolumn=81',
    group = aug,
})

au('InsertLeave', {
    command = 'se colorcolumn=',
    group = aug,
})

au('FocusLost', {
    command = 'se nocursorline',
    group = aug,
})

au('ColorScheme', {
    command = [[se statusline=%{%v:lua.require'statusline'.statusline()%}]],
    group = aug,
})

au('ModeChanged', {
    callback = function()
        require('paqs.luasnippets.utils').leave_snippet()
    end,
    group = aug,
})

au('BufEnter', {
    callback = function()
        if vim.wo.foldmethod ~= 'marker' then
            vim.cmd 'setl foldmethod=expr'
        end

        vim.cmd 'setl formatoptions-=cro'

        if vim.api.nvim_eval 'FugitiveHead()' ~= '' then
            vim.cmd 'setl signcolumn=yes:2'
        end

        local ft = vim.bo.ft

        if ft == 'fugitive' then
            vim.cmd 'setl signcolumn=no'
        elseif utils.empty(ft) and utils.empty(vim.bo.bt) then
            vim.cmd 'LspStop | setl signcolumn=no'
        end
    end,
    group = aug,
})

au('TextYankPost', {
    callback = function()
        vim.highlight.on_yank { higroup = 'RedrawDebugNormal', timeout = '700' }
    end,
    group = aug,
})

au('TermOpen', {
    command = 'setl nonumber norelativenumber nospell nocursorline signcolumn=no | start',
    group = aug,
})
