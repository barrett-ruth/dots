local utils = require 'utils'
local map = utils.map
local mapstr = utils.mapstr

-- Buffers --
map { 'n', '[b', mapstr 'bp' }
map { 'n', ']b', mapstr 'bn' }
map { 'n', '<leader>B', mapstr 'bd' }

-- Builtins --
map { 'n', ':', ';' }
map { 'n', ';', ':' }
map { 'v', ':', ';' }
map { 'v', ';', ':' }
map { 'v', '$', 'g_' }
vim.cmd "nn <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'"
map { 'n', 'J', 'mzJ`z' }
map { 'v', 'J', ":m '>+1<cr>gv" }
map { 'v', 'K', ":m '<-2<cr>gv" }
map { 'n', 'x', '"_x' }
map { 'n', 'Q', 'q:' }
map { 'n', 'zH', '15zH' }
map { 'n', 'zL', '15zL' }
map { 'n', '<bs>', '<c-^>' }
map { 'n', '<c-i>', '<c-i>zz' }
map { 'n', '<c-o>', '<c-o>zz' }
map { 't', '<esc>', '<c-\\><c-n>' }

-- Centering --
map { 'n', 'G', 'Gzz' }
map { 'n', 'n', 'nzzzv' }
map { 'n', 'N', 'Nzzzv' }
map { 'n', '<c-d>', '<c-d>zz' }
map { 'n', '<c-u>', '<c-u>zz' }

-- Windows --
map { 'n', '<c-h>', '<c-w>h' }
map { 'n', '<c-j>', '<c-w>j' }
map { 'n', '<c-k>', '<c-w>k' }
map { 'n', '<c-l>', '<c-w>l' }
map { 'n', '<c-w>h', '<c-w>H' }
map { 'n', '<c-w>j', '<c-w>J' }
map { 'n', '<c-w>k', '<c-w>K' }
map { 'n', '<c-w>l', '<c-w>L' }

-- Miscellaneous
map { 'n', '<leader><cr>', mapstr('utils', 'source()') }
map { 'n', '<leader>-', 'S<esc>' }
map { 'n', '<leader>o', 'mm' .. mapstr '%bd|e#|bd#' .. '`mzz' }
map { 'n', '<leader>r', mapstr('utils', 'save()') .. mapstr 'vs|te run %' }
map { 'n', '<leader>S', mapstr 'vert sbp' }

-- Location List --
map { 'n', ']l', mapstr 'bd' .. mapstr 'lne' .. 'zz' }
map { 'n', '[l', mapstr 'bd' .. mapstr 'lp' .. 'zz' }
map { 'n', ']L', mapstr 'lne' .. 'zz' }
map { 'n', '[L', mapstr 'lp' .. 'zz' }
map { 'n', '<leader>l', mapstr('utils', "toggle_list('l')") }
map { 'n', '<leader>L', mapstr 'cal setloclist(0, []) | lcl' }

-- Quickfix List --
map { 'n', ']c', mapstr 'bd' .. mapstr 'cn' .. 'zz' }
map { 'n', '[c', mapstr 'bd' .. mapstr 'cp' .. 'zz' }
map { 'n', ']C', mapstr 'cn' .. 'zz' }
map { 'n', '[C', mapstr 'cp' .. 'zz' }
map { 'n', '<leader>c', mapstr('utils', "toggle_list('c')") }
map { 'n', '<leader>C', mapstr 'cal setqflist([]) | ccl' }

-- Newlines --
map { 'n', ']o', '@="m`o\\eg``"<cr>' }
map { 'n', '[o', '@="m`O\\eg``"<cr>' }

-- Deleting/yanking/pasting --
map { '', '<leader>d', '"_d' }
map { '', '<leader>p', '"0P' }
map { '', '<leader>y', '"+y' }
map { '', '<leader>Y', mapstr '%y+"' }

-- Resizing --
map { 'n', '<left>', mapstr 'vert res -10' }
map { 'n', '<down>', mapstr 'res +10' }
map { 'n', '<up>', mapstr 'res -10' }
map { 'n', '<right>', mapstr 'vert res +10' }

-- Saving/Exiting --
map { 'n', '<leader>q', mapstr 'q' }
map { 'n', '<leader>Q', mapstr 'q!' }
map { 'n', '<leader>w', mapstr('utils', 'save()') }
map { 'n', '<leader>z', 'ZZ' }
map { 'n', '<leader>Z', mapstr 'xa' }

-- Swaplines --
map { 'n', '[e', '@="m`:m-2\\eg``"<cr>' }
map { 'n', ']e', '@="m`:m+\\eg``"<cr>' }

-- Toggling --
map { 'n', '<leader>iw', mapstr 'setl invwrap' }
map { 'n', '<leader>is', mapstr 'setl invspell' }
