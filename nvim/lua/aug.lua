local aug = vim.api.nvim_create_augroup('augs', { clear = true })
local au = vim.api.nvim_create_autocmd

au('BufEnter', {
    callback = function()
        vim.cmd 'setl fo-=cro'
        if vim.api.nvim_eval 'fugitive#head()' ~= '' then
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

au('Filetype', {
    pattern = 'qf',
    callback = function()
        local utils = require 'utils'
        local bmap = utils.bmap
        local mapstr = utils.mapstr

        bmap { 'n', '<c-v>', '<cr>' .. mapstr 'bp' .. mapstr 'vert sbn' }
    end,
    group = aug,
})

au('Filetype', {
    pattern = {
        'javascript',
        'javascriptreact',
        'lua',
        'python',
        'typescript',
        'typescriptreact',
        'vim',
        'sh',
    },
    callback = function()
        local utils = require 'utils'
        local bmap = utils.bmap
        local mapstr = utils.mapstr

        bmap { 'v', '<leader>rf', '<esc>' .. mapstr('refactoring', "refactor 'Extract Function'") }
        bmap { 'v', '<leader>re', '<esc>' .. mapstr('utils', 'refactor_extract()') }
        bmap { 'v', '<leader>ri', '<esc>' .. mapstr('utils', 'refactor_inline()') }
        bmap { 'v', '<leader>rp', '<esc>' .. mapstr('utils', 'refactor_print()') }
    end,
    group = aug,
})
