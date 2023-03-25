local api = vim.api
local au = api.nvim_create_autocmd

local aug = api.nvim_create_augroup('AAugs', {})

au('BufEnter', {
    command = 'setl formatoptions-=cro spelloptions=camel,noplainbuffer',
    group = aug,
})

au({ 'WinEnter', 'BufWinEnter' }, {
    command = 'se cursorline',
    group = aug,
})

au('WinLeave', {
    command = 'se nocursorline',
    group = aug,
})

au('VimResized', {
    command = 'wincmd =',
    group = aug,
})

au('VimEnter', {
    callback = function(opts)
        vim.pretty_print(opts.file)
        if vim.fn.isdirectory(opts.file) == 1 then
            require('nvim-tree.api').tree.open()
        end
    end,
    group = aug,
})

au('ModeChanged', {
    command = 'let &hlsearch = index(["?", "/"], getcmdtype()) > -1',
    group = aug,
})

au('BufReadPost', {
    command = 'sil! norm g`"',
    group = aug,
})

au('BufEnter', {
    pattern = '*.env*',
    command = 'se ft=env',
    group = aug,
})

au('TextYankPost', {
    command = 'lua vim.highlight.on_yank { higroup = "RedrawDebugNormal", timeout = "300" }',
    group = aug,
})
