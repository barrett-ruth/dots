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
map { 'n', ']p', '}' }
map { 'n', '[p', '{' }
-- :]

-- Folds [:
map { 'n', ']z', 'zj' }
map { 'n', '[z', 'zk' }
-- :]

-- Windows [:
map { 'n', '<tab>', '<c-w>' }
-- :]

-- Miscellaneous [:
map { 'n', '<leader><cr>', mapstr 'so' }
map { 'n', '<leader>-', 'S<esc>' }
map { 'n', 'x', '"_x' }
map { 'n', 'ga', '<Plug>(EasyAlign)' }
map { 'x', 'ga', '<Plug>(EasyAlign)' }
map({ 'x', 'R', '<esc>gv"ry:%s/<c-r>r//g<left><left>' }, { silent = false })
map { 'n', 'J', 'mzJ`z' }
map { 'n', 'Q', 'q:k' }
map { 'n', '<bs>', '<c-^>' }
map { 'n', '<c-d>', '<c-d>zz' }
map { 'n', '<c-u>', '<c-u>zz' }
map { 'n', 'H', 'zH' }
map { 'n', 'L', 'zL' }
map({ 'c', '<c-p>', '<up>' }, { silent = false })
map({ 'c', '<c-n>', '<down>' }, { silent = false })
map({ 'c', ';', 'norm ' }, { silent = false })
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
map { 'v', '<leader>p', '"_dP' }
map { '', '<leader>y', '"+y' }
-- :]

-- Saving/Exiting [:
map {
    'n',
    '<leader>q',
    mapstr 'q',
}
map { 'n', '<leader>Q', mapstr 'qa!' }
map {
    'n',
    '<leader>w',
    function()
        vim.cmd 'w'
        require('utils').format()
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
map { 'n', '<leader>ic', mapstr 'let &l:ch = (&ch + 1) % 2' }
map { 'n', '<leader>is', mapstr 'setl invspell' }
map { 'n', '<leader>iw', mapstr 'setl invwrap' }
-- :]
