local au = vim.api.nvim_create_autocmd
local aug = vim.api.nvim_create_augroup('augs', { clear = true })

au('BufEnter', {
    pattern = 'PKGBUILD',
    command = 'se filetype=PKGBUILD',
    group = aug,
})

au('FocusLost', {
    callback = function()
        vim.o.cursorline = false
        if not require('utils').empty(vim.fn.bufname()) then
            vim.cmd 'wall'
        end
    end,
    group = aug,
})

au('InsertEnter', {
    command = 'setl colorcolumn=80',
    group = aug,
})

au('InsertLeave', {
    command = 'setl colorcolumn=',
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
    command = 'setl formatoptions-=cro',
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
