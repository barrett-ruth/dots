local au = vim.api.nvim_create_autocmd
local aug = vim.api.nvim_create_augroup('augs', { clear = true })

local utils = require 'utils'
local bmap, mapstr = utils.bmap, utils.mapstr

au('FileType', {
    pattern = 'man',
    command = 'setl signcolumn=no number relativenumber nospell',
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

au('VimResized', {
    command = 'redrawstatus',
    group = aug,
})

au('FileType', {
    pattern = 'PKGBUILD',
    command = 'se filetype=PKGBUILD',
    group = aug,
})

au('BufEnter', {
    callback = function()
        vim.cmd 'setl formatoptions-=cro'

        if vim.api.nvim_eval 'FugitiveHead()' ~= '' then
            vim.cmd 'setl signcolumn=yes:2'
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
    command = 'setl nonumber norelativenumber nospell signcolumn=no | start',
    group = aug,
})

au('FileType', {
    pattern = 'qf',
    callback = function()
        bmap { 'n', 'q', mapstr 'q' }

        vim.cmd 'setl statusline='
    end,
    group = aug,
})
