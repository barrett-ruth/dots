local au = vim.api.nvim_create_autocmd
local aug = vim.api.nvim_create_augroup('augs', { clear = true })

au('FileType', {
    pattern = 'man',
    command = 'se scl=no nu rnu',
    group = aug,
})

au('ModeChanged', {
    callback = function()
        require('utils').leave_snippet()
    end,
    group = aug,
})

au({ 'BufRead', 'BufNewFile' }, {
    pattern = 'PKGBUILD',
    command = 'se ft=PKGBUILD',
    group = aug,
})

au('BufEnter', {
    callback = function()
        vim.cmd 'setl fo-=cro'

        if vim.api.nvim_eval 'FugitiveHead()' ~= '' then
            vim.cmd 'setl scl=yes:2'
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
    command = 'setl nonu nornu scl=no | start',
    group = aug,
})

au('FileType', {
    pattern = 'qf',
    callback = function()
        local utils = require 'utils'
        local mapstr = utils.mapstr

        utils.bmap { 'n', '<c-v>', '<cr>' .. mapstr 'bp' .. mapstr 'vert sbn' }
        utils.bmap { 'n', 'q', mapstr 'q' }

        vim.cmd 'setl stl='
    end,
    group = aug,
})
