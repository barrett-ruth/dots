local api, fn = vim.api, vim.fn

local au = api.nvim_create_autocmd
local aug = api.nvim_create_augroup('augs', { clear = true })

au('BufEnter', {
    pattern = 'PKGBUILD',
    command = 'se filetype=sh',
    group = aug,
})

au('QuitPre', {
    callback = function()
        local bufname = 'scratch' .. fn.bufnr()
        local scratch_bufnr = fn.bufnr(bufname)

        if scratch_bufnr ~= -1 then vim.cmd('BufDel! ' .. bufname) end
    end,
    group = aug,
})

local disable_save = { '', 'checkhealth' }

au({ 'FocusLost', 'WinLeave' }, {
    callback = function()
        vim.wo.cursorline = false

        if not vim.tbl_contains(disable_save, vim.bo.filetype) then
            vim.cmd 'sil wall'
        end
    end,
    group = aug,
})

au({ 'FocusGained', 'WinEnter' }, {
    command = 'setl cursorline',
    group = aug,
})

au('InsertLeave', {
    command = [[lua require('paqs.luasnippets.utils').leave_snippet()]],
    group = aug,
})

au('ColorScheme', {
    command = [[se statusline=%{%v:lua.require'statusline'.statusline()%}]],
    group = aug,
})

au('BufEnter', {
    callback = function()
        vim.cmd 'setl formatoptions-=cro spelloptions=camel,noplainbuffer'

        -- Ignore floating windows
        if vim.bo.filetype == '' then return end

        -- Show winbar on inactive buffers
        for _, buf in ipairs(fn.getbufinfo { buflisted = 1 }) do
            local winid = fn.bufwinid(buf.bufnr)

            if
                winid ~= -1
                and api.nvim_buf_get_option(buf.bufnr, 'filetype') ~= ''
            then
                api.nvim_win_set_option(
                    fn.bufwinid(buf.bufnr),
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
    command = 'setl nonumber norelativenumber nocursorline signcolumn=no | start',
    group = aug,
})
