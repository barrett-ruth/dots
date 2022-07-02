local au = vim.api.nvim_create_autocmd
local aug = vim.api.nvim_create_augroup('augs', { clear = true })

au('BufEnter', {
    pattern = 'PKGBUILD',
    command = 'se filetype=PKGBUILD',
    group = aug,
})

au('FocusLost', {
    command = 'se nocursorline',
    group = aug,
})

au('InsertEnter', {
    callback = function()
        vim.cmd 'setl colorcolumn=80'
    end,
    group = aug,
})

au('InsertLeave', {
    callback = function()
        vim.cmd 'setl colorcolumn='
    end,
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
        vim.cmd 'setl formatoptions-=cro'

        if vim.bo.ft == 'fugitive' then
            vim.cmd 'setl signcolumn=no'
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
