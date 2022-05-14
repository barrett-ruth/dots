local aug = vim.api.nvim_create_augroup('augs', { clear = true })
local au = vim.api.nvim_create_autocmd

au('VimLeave', {
    command = 'NvimTreeClose',
    group = aug,
})

au('ColorScheme', {
    command = 'so ~/.config/nvim/plugin/theme.vim',
    group = aug,
})

au('FileType', {
    pattern = 'man',
    command = 'se scl=no nu rnu',
    group = aug,
})

au('Syntax', {
    command = 'so ~/.config/nvim/after/syntax.vim',
    group = aug,
})

au('BufWrite', {
    callback = function()
        if vim.fn.expand '%' == os.getenv 'XDG_CONFIG_HOME' .. '/dunst/dunstrc' then
            vim.fn.system 'killall dunst; dunst &; disown'
        end
    end,
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
