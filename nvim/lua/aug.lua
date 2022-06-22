local au = vim.api.nvim_create_autocmd
local aug = vim.api.nvim_create_augroup('augs', { clear = true })

au('BufEnter', {
    pattern = 'PKGBUILD',
    command = 'se filetype=PKGBUILD',
    group = aug,
})

au('InsertEnter', {
    command = 'se cursorline',
    group = aug,
})

au('InsertLeave', {
    command = 'se nocursorline',
    group = aug,
})

au('ColorScheme', {
    command = [[se statusline=%{%v:lua.require'statusline'.statusline()%}]],
    group = aug,
})

au('VimLeave', {
    callback = function()
        vim.fn.system 'rm -rf /tmp/lua-language-server*'
    end,
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
        vim.cmd 'setl formatoptions-=cro foldmethod=expr'

        if vim.api.nvim_eval 'FugitiveHead()' ~= '' then
            vim.cmd 'setl signcolumn=yes:2'
        end

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
