local api = vim.api
local au = api.nvim_create_autocmd

local aug = api.nvim_create_augroup('AAugs', {})

au('BufEnter', {
    command = 'setl formatoptions-=cro spelloptions=camel,noplainbuffer',
    group = aug,
})

au('VimResized', {
    command = 'wincmd =',
    group = aug,
})

au('ModeChanged', {
    command = 'let &hlsearch = index(["?", "/"], getcmdtype()) > -1',
    group = aug,
})

au('BufReadPost', {
    command = 'norm g`"',
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
