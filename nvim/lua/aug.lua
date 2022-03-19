local aug = vim.api.nvim_create_augroup('aug', { clear = true })
local au = vim.api.nvim_create_autocmd

au('BufEnter', { command = 'setl fo-=cro', group = aug })
au('TextYankPost', {
    callback = function()
        vim.highlight.on_yank { higroup = 'RedrawDebugNormal', timeout = '700' }
    end,
    group = aug,
})
au('Filetype', {
    pattern = { 'sh', 'bash', 'zsh' },
    command = 'so ~/.config/nvim/lua/plug/luasnip/sh.lua',
    group = aug
})
au('Filetype', {
    pattern = { 'html', 'javascript', 'javascriptreact', 'lua', 'python', 'qf', 'typescript', 'typescriptreact', 'vim' },
    callback = function()
        vim.cmd('so ~/.config/nvim/lua/plug/luasnip/' .. vim.bo.ft .. '.lua')
    end,
    group = aug
})
