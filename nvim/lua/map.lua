local utils = require 'utils'
local map, mapstr = utils.map, utils.mapstr

-- Buffers [:
map { 'n', ']b', mapstr 'bnext' }
map { 'n', '[b', mapstr 'bprev' }
map { 'n', '<leader>bw', mapstr 'BufDel!' }
map { 'n', '<leader>bd', mapstr 'BufDel' }
map { 'n', '<c-b>', mapstr 'FzfLua buffers' }
-- :]

-- Builtins [:
map({ 'n', ':', ';' }, { silent = false })
map({ 'n', ';', ':' }, { silent = false })
map({ 'x', ':', ';' }, { silent = false })
map({ 'x', ';', ':' }, { silent = false })
map { 'n', 'V', 'v' }
map { 'n', 'v', 'V' }
map { 'x', 'V', 'v' }
map { 'x', 'v', 'V' }
map { 'n', ']p', '}' }
map { 'n', '[p', '{' }
map { 'n', 'ga', '<Plug>(EasyAlign)' }
map { 'x', 'ga', '<Plug>(EasyAlign)' }
-- :]

-- Folds [:
map { 'n', ']z', 'zj' }
map { 'n', '[z', 'zk' }
-- :]

-- Windows [:
map { 'n', '<tab>', '<c-w>' }
-- :]

-- Miscellaneous [:
map {
    'n',
    '<leader><cr>',
    function()
        local file = string.match(vim.fn.expand '%', 'lua/(.*).lua')

        if vim.bo.ft == 'lua' then
            package.loaded[file] = nil
        end

        vim.cmd 'so %'
    end,
}
map { 'n', '<leader>-', 'S<esc>' }
map {
    'n',
    '<leader>r',
    function()
        vim.cmd 'vs|te run %'
    end,
}
map({ 'x', 'R', '<esc>gv"ry:%s/<c-r>r//g<left><left>' }, { silent = false })
map { 'n', 'J', 'mzJ`z' }
map { 'n', 'K', 'mzkJ`z' }
map { 'n', 'Q', 'q:k' }
map { 'n', '<bs>', '<c-^>' }
vim.cmd 'cno <c-n> <down>'
-- :]

-- Location List [:
map { 'n', ']l', mapstr 'lnext' }
map { 'n', '[l', mapstr 'lprev' }
map { 'n', '<leader>l', mapstr 'FzfLua loclist' }
map { 'n', '<leader>L', mapstr 'cal setloclist(0, []) | lcl' }
-- :]

-- Quickfix List [:
map { 'n', ']q', mapstr 'cnext' }
map { 'n', '[q', mapstr 'cprev' }
map { 'n', '<leader>c', mapstr 'FzfLua quickfix' }
map { 'n', '<leader>C', mapstr 'cal setqflist([]) | ccl' }
-- :]

-- Newlines [:
map { 'n', ']o', '@="m`o\\eg``"<cr>' }
map { 'n', '[o', '@="m`O\\eg``"<cr>' }
-- :]

-- Deleting/yanking/pasting [:
map { '', '<leader>d', '"_d' }
map { '', '<leader>y', '"+y' }
-- :]

-- Resizing [:
map { 'n', '<c-left>', mapstr 'vertical resize -10' }
map { 'n', '<c-down>', mapstr 'resize +10' }
map { 'n', '<c-up>', mapstr 'resize -10' }
map { 'n', '<c-right>', mapstr 'vertical resize +10' }
-- :]

-- Saving/Exiting [:
map { 'n', '<leader>q', mapstr 'q' }
map { 'n', '<leader>Q', mapstr 'q!' }
map {
    'n',
    '<leader>w',
    function()
        vim.lsp.buf.format { bufnr = vim.fn.bufnr '%' }
        vim.cmd 'w'
    end,
    { silent = false },
}
map { 'n', '<leader>z', 'ZZ' }
map { 'n', '<leader>Z', mapstr 'wqall' }
-- :]

-- Swapping lines [:
map { 'n', ']e', '<cmd>m+<cr>' }
map { 'n', '[e', '<cmd>m-2<cr>' }
-- :]

-- Toggling [:
map { 'n', '<leader>iw', mapstr 'setl invwrap' }
map {
    'n',
    '<leader>is',
    function()
        SPELLSITTER_ENABLED = (SPELLSITTER_ENABLED == nil) and false
            or not SPELLSITTER_ENABLED

        if SPELLSITTER_ENABLED then
            require('spellsitter').setup { enable = { 'none' } }
        else
            require('spellsitter').setup { enable = true }
        end
    end,
}
-- :]
