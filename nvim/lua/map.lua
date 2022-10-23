local utils = require 'utils'
local map, mapstr = utils.map, utils.mapstr

-- Buffers [:
map { 'n', ']b', mapstr 'bnext' }
map { 'n', '[b', mapstr 'bprev' }
map { 'n', '<leader>bw', mapstr 'BufDel!' }
map { 'n', '<leader>bd', mapstr 'BufDel' }
-- :]

-- Builtins [:
map({ 'n', ':', ';' }, { silent = false })
map({ 'n', ';', ':' }, { silent = false })
map({ 'x', ':', ';' }, { silent = false })
map({ 'x', ';', ':' }, { silent = false })
map { 'n', ']p', '}' }
map { 'n', '[p', '{' }
map { 'n', ']d', ']s' }
map { 'n', '[d', '[s' }
-- :]

-- Folds [:
map { 'n', ']z', 'zj' }
map { 'n', ']Z', 'zo]z' }
map { 'n', '[z', 'zk' }
map { 'n', '[Z', 'zo[z' }
-- :]

-- Windows [:
map { 'n', 'H', '<c-w>h' }
map { 'n', 'J', '<c-w>j' }
map { 'n', '<c-j>', 'mzJ`z' }
map { 'n', 'K', '<c-w>k' }
map { 'n', '<c-k>', 'mzkJ`z' }
map { 'n', 'L', '<c-w>l' }
map { 'n', '<leader>k', 'K' }
-- :]

-- Miscellaneous [:
map { 'n', '<leader><cr>', mapstr 'so' }
map { 'n', 'Q', 'q:k' }
map { 'n', '<bs>', '<c-^>' }
map({ 'c', '<c-p>', '<up>' }, { silent = false })
map({ 'c', '<c-n>', '<down>' }, { silent = false })
map({ 'c', ';;', 'norm ' }, { silent = false })
map { 'v', 'J', [[:m '>+1<cr>gv=gv]] }
map { 'v', 'K', [[:m '<-2<cr>gv=gv]] }
-- :]

-- Location List [:
map { 'n', ']l', mapstr 'lnext' }
map { 'n', '[l', mapstr 'lprev' }
map { 'n', '<leader>L', mapstr 'cal setloclist(0, []) | lcl' }
-- :]

-- Quickfix List [:
map { 'n', ']q', mapstr 'cnext' }
map { 'n', '[q', mapstr 'cprev' }
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
    mapstr 'w',
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
