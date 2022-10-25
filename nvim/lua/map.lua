local cmd = vim.cmd

local utils = require 'utils'
local map, mapstr = utils.map, utils.mapstr

-- Buffers [:
map { 'n', ']b', cmd.bnext }
map { 'n', '[b', cmd.bprev }
map {
    'n',
    '<leader>bw',
    function()
        local bufnr = vim.fn.bufnr()
        cmd 'BufDel!'
        cmd.bw(bufnr)
    end,
}
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
map { 'n', ']z', 'zjzo' }
map { 'n', ']Z', ']z' }
map { 'n', '[z', 'zkzo[z' }
map { 'n', '[Z', '[z' }
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
map { 'n', '<leader><cr>', cmd.source }
map { 'n', '<leader>-', 'S<esc>' }
map { 'n', 'Q', 'q:k' }
map { 'n', '<bs>', '<c-^>' }
map({ 'c', '<c-p>', '<up>' }, { silent = false })
map({ 'c', '<c-n>', '<down>' }, { silent = false })
map({ 'c', ';;', 'norm ' }, { silent = false })
map { 'v', 'J', [[:m '>+1<cr>gv=gv]] }
map { 'v', 'K', [[:m '<-2<cr>gv=gv]] }
-- :]

-- Location List [:
map { 'n', ']l', cmd.lnext }
map { 'n', '[l', cmd.lprev }
map { 'n', '<leader>L', mapstr 'cal setloclist(0, []) | lcl' }
-- :]

-- Quickfix List [:
map { 'n', ']q', cmd.cnext }
map { 'n', '[q', cmd.cprev }
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
    cmd.q,
}
map { 'n', '<leader>Q', mapstr 'qa!' }
map {
    'n',
    '<leader>w',
    cmd.w,
    { silent = false },
}
map { 'n', '<leader>z', 'ZZ' }
map { 'n', '<leader>Z', cmd.wqall }
-- :]

-- Swapping lines [:
map { 'n', ']e', mapstr 'm+' }
map { 'n', '[e', mapstr 'm-2' }
-- :]

-- Toggling [:
map { 'n', '<leader>ic', mapstr 'let &l:ch = (&ch + 1) % 2' }
map { 'n', '<leader>is', mapstr 'setl spell!' }
map { 'n', '<leader>iw', mapstr 'setl wrap!' }
-- :]
