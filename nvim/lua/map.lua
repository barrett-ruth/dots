local utils = require 'utils'
local map = utils.map
local mapstr = utils.mapstr

-- Location List --
map { 'n', ']l', mapstr 'lne' .. 'zz' }
map { 'n', '[l', mapstr 'lp' .. 'zz' }
map { 'n', '<leader>l', mapstr('utils', "toggle_list('l')") }
map { 'n', '<leader>L', mapstr 'cal setloclist(0, []) | sil lcl' }

-- Quickfix List --
map { 'n', ']c', mapstr 'cn' .. 'zz' }
map { 'n', '[c', mapstr 'cp' .. 'zz' }
map { 'n', '<leader>c', mapstr('utils', "toggle_list('c')") }
map { 'n', '<leader>C', mapstr 'cal setqflist([]) | sil ccl' }

-- Builtins --
map { 'n', '<bs>', '<c-^>' }
map { 'n', 'Q', mapstr('utils', 'Q()') }
map { 'n', 'J', 'mzJ`z' }
map { 'v', 'K', ":m '<-2<cr>gv" }
map { 'v', 'J', ":m '>+1<cr>gv" }
map { 'n', 'x', '"_x' }

-- Windows --
map { 'n', '<c-h>', '<c-w>h' }
map { 'n', '<c-j>', '<c-w>j' }
map { 'n', '<c-k>', '<c-w>k' }
map { 'n', '<c-l>', '<c-w>l' }

map { 'n', '<c-left>', mapstr 'vert resize -10' }
map { 'n', '<c-down>', mapstr 'resize +10' }
map { 'n', '<c-up>', mapstr 'resize -10' }
map { 'n', '<c-right>', mapstr 'vert resize +10' }

-- Centering --
map { 'n', 'G', 'Gzz' }
map { 'n', 'n', 'nzzzv' }
map { 'n', 'N', 'Nzzzv' }
map { 'n', '<c-d>', '<c-d>zz' }
map { 'n', '<c-u>', '<c-u>zz' }

-- Movements --
map { 'n', 'H', '0' }
map { 'n', 'L', '$' }
map { 'n', 'zH', '15zH' }
map { 'n', 'zL', '15zL' }

map { 'n', '<leader><cr>', mapstr 'so %' }

map { 'n', '<leader>H', '`[v`]' }

map { 'n', '<leader>i', ':se inv' }

map { 'n', '<leader>bd', mapstr 'bd' }
map { 'n', '<leader>bn', mapstr 'bn' }
map { 'n', '<leader>bp', mapstr 'bp' }

map { 'n', '<leader>S', mapstr 'vert sbn' }

map { '', '<leader>y', '"+y' }
map { '', '<leader>Y', 'mzgg"+yG`zzz' }

map { 'n', '<leader>q', mapstr 'q' }
map { 'n', '<leader>Q', mapstr 'q!' }
map { 'n', '<leader>w', mapstr 'w' }
map { 'n', '<leader>W', mapstr 'wa' }
map { 'n', '<leader>z', 'ZZ' }
map { 'n', '<leader>Z', mapstr 'xa' }

-- No yanking --
map { '', '<leader>d', '"_d' }
map { '', '<leader>r', '"_dP' }

-- Last yanked item
map { '', '<leader>p', '"0p' }

map { 'n', '<leader>f', mapstr('utils', 'format()') }
map { 'n', '<leader>F', ':se fdm=' }

map { 'n', ']o', 'mzo<esc>`z' }
map { 'n', '[o', 'mzO<esc>`z' }

-- Swap : and ;
map { 'n', ':', ';' }
map { 'n', ';', ':' }
map { 'n', 'q;', 'q:' }

map { 'v', ':', ';' }
map { 'v', ';', ':' }
