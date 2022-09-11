local au = vim.api.nvim_create_autocmd
local aug = vim.api.nvim_create_augroup('augs', { clear = true })

au('BufEnter', {
    pattern = 'PKGBUILD',
    command = 'se filetype=PKGBUILD',
    group = aug,
})

au('QuitPre', {
    callback = function()
        local bufname = 'scratch' .. vim.fn.bufnr()
        local scratch_bufnr = vim.fn.bufnr(bufname)

        if scratch_bufnr ~= -1 then vim.cmd('BufDel! ' .. bufname) end
    end,
    group = aug,
})

local save_disabled = { '', 'dirbuf' }

au({ 'FocusLost', 'WinLeave' }, {
    callback = function()
        vim.wo.cursorline = false

        if not vim.tbl_contains(save_disabled, vim.o.filetype) then
            vim.cmd 'wall'
        end
    end,
    group = aug,
})

au({ 'FocusGained', 'WinEnter' }, {
    command = 'setl cursorline',
    group = aug,
})

au('InsertEnter', {
    command = 'setl colorcolumn=80|norm zz',
    group = aug,
})

au('InsertLeave', {
    command = [[setl colorcolumn= | lua require('paqs.luasnippets.utils').leave_snippet()]],
    group = aug,
})

au('ColorScheme', {
    command = [[se statusline=%{%v:lua.require'statusline'.statusline()%}]],
    group = aug,
})

au('BufEnter', {
    callback = function()
        vim.cmd 'setl formatoptions-=cro spelloptions=camel'

        for _, buf in ipairs(vim.fn.getbufinfo { buflisted = 1 }) do
            local winid = vim.fn.bufwinid(buf.bufnr)

            if winid ~= -1 then
                vim.api.nvim_win_set_option(
                    vim.fn.bufwinid(buf.bufnr),
                    'winbar',
                    [[%{%v:lua.require'winbar'.winbar()%}]]
                )
            end
        end

        vim.opt_local.winbar = nil
    end,
    group = aug,
})

au('TextYankPost', {
    command = [[lua vim.highlight.on_yank { higroup = 'RedrawDebugNormal', timeout = '700' }]],
    group = aug,
})

au('TermOpen', {
    command = 'setl nonumber norelativenumber nospell nocursorline signcolumn=no | start',
    group = aug,
})
