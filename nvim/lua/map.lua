local utils = require 'utils'
local map, mapstr = utils.map, utils.mapstr

-- Buffers --
map { 'n', '[b', mapstr 'bp' }
map { 'n', ']b', mapstr 'bn' }
map { 'n', '<leader>bd', mapstr 'BufDel' }
map { 'n', '<leader>bw', mapstr 'BufDel!' }
map { 'n', '<c-b>', mapstr 'FzfLua buffers' }

-- Builtins --
map({ 'n', ':', ';' }, { silent = false })
map({ 'n', ';', ':' }, { silent = false })
map({ 'x', ':', ';' }, { silent = false })
map({ 'x', ';', ':' }, { silent = false })
map { 'n', 'x', '"_x' }

-- Windows --
map { 'n', '<c-h>', '<c-w>h' }
map { 'n', '<c-j>', '<c-w>j' }
map { 'n', '<c-k>', '<c-w>k' }
map { 'n', '<c-l>', '<c-w>l' }
map { 'n', '<c-w>h', '<c-w>H' }
map { 'n', '<c-w>j', '<c-w>J' }
map { 'n', '<c-w>k', '<c-w>K' }
map { 'n', '<c-w>l', '<c-w>L' }

-- Miscellaneous --
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
map({ 'n', '<leader>R', [[:%s/<c-r>=expand('<cword>')<cr>//g<left><left>]] }, { silent = false })
map({ 'x', '<leader>R', '<esc>gv"ry:%s/<c-r>r//g<left><left>' }, { silent = false })
map { 'n', 'J', 'mzJ`z' }
map { 'n', 'K', 'mzkJ`z' }
map { 'n', 'Q', 'q:k' }
map { 'n', '<leader>k', 'K' }
vim.cmd [[
    cno <c-n> <down>
    xn J :m '>+1<cr><esc>gv
    xn K :m '<-2<cr><esc>gv
]]

-- Folds --
map { 'n', ']z', 'zj' }
map { 'n', '[z', 'zk' }
map { 'n', 'zt', 'zA', }

-- Location List --
map { 'n', ']l', mapstr 'lne' }
map { 'n', '[l', mapstr 'lp' }
map { 'n', '<leader>l', mapstr('fzf-lua', 'loclist({})') }
map { 'n', '<leader>L', mapstr 'cal setloclist(0, []) | lcl' }

-- Quickfix List --
map { 'n', ']c', mapstr 'cn' }
map { 'n', '[c', mapstr 'cp' }
map { 'n', '<leader>c', mapstr('fzf-lua', 'quickfix({})') }
map { 'n', '<leader>C', mapstr 'cal setqflist([]) | ccl' }

-- Newlines --
map { 'n', ']o', '@="m`o\\eg``"<cr>' }
map { 'n', '[o', '@="m`O\\eg``"<cr>' }

-- Deleting/yanking/pasting --
map { '', '<leader>d', '"_d' }
map { '', '<leader>p', '"0p' }
map { '', '<leader>y', '"+y' }

-- Resizing --
map { 'n', '<c-left>', mapstr 'vert res -10' }
map { 'n', '<c-down>', mapstr 'res +10' }
map { 'n', '<c-up>', mapstr 'res -10' }
map { 'n', '<c-right>', mapstr 'vert res +10' }

-- Saving/Exiting --
map { 'n', '<leader>q', mapstr 'q' }
map { 'n', '<leader>Q', mapstr 'q!' }
map {
    'n',
    '<leader>w',
    function()
        vim.cmd 'w|sil lua vim.lsp.buf.format()'
    end,
    { silent = false },
}
map { 'n', '<leader>z', 'ZZ' }
map { 'n', '<leader>Z', mapstr 'xa' }

-- Swapping lines --
map { 'n', '[e', '@="m`:m-2\\eg``"<cr>' }
map { 'n', ']e', '@="m`:m+\\eg``"<cr>' }

-- Toggling --
map { 'n', '<leader>iw', mapstr 'setl invwrap' }
