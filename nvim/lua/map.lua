local utils = require 'utils'
local map = utils.map

local mapstr = utils.mapstr
-- Location List --
local ll = '<leader>l'
map { 'n', ']l', mapstr 'lne' }
map { 'n', '[l', mapstr 'lp' }
map { 'n', ll .. 'd', ':ldo ' }
map { 'n', ll .. 't', mapstr('utils', "toggle_list('l')") }

-- Quickfix List --
local ql = '<leader>c'
map { 'n', ']c', mapstr 'cn' }
map { 'n', '[c', mapstr 'cp' }
map { 'n', ql .. 'd', ':cdo ' }
map { 'n', ql .. 't', mapstr('utils', "toggle_list('c')") }

-- Builtins --
map { 'n', '<bs>', '<c-^>' }
map { 'n', 'Q', mapstr('utils', 'Q()') }
map { 'n', 'J', 'mzJ`z' }
map { 'v', 'K', ":m '<-2<cr>gv" }
map { 'v', 'J', ":m '>+1<cr>gv" }

-- Windows --
map { 'n', '<c-h>', '<c-w>h' }
map { 'n', '<left>', mapstr 'vert resize -10' }
map { 'n', '<c-j>', '<c-w>j' }
map { 'n', '<down>', mapstr 'resize +10' }
map { 'n', '<c-k>', '<c-w>k' }
map { 'n', '<up>', mapstr 'resize -10' }
map { 'n', '<c-l>', '<c-w>l' }
map { 'n', '<right>', mapstr 'vert resize +10' }

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

map { 'n', '<leader>i', ':se inv' }

map { 'n', '<leader>C', mapstr('utils', 'clean_whitespace()') }

map { 'n', '<leader>S', mapstr 'vert sbp' }

map { '', '<leader>y', '"+y' }
map { '', '<leader>Y', 'mzgg"+yG`zzz' }

map { 'n', '<leader>q', mapstr 'q' }
map { 'n', '<leader>Q', mapstr 'q!' }
map { 'n', '<leader>w', mapstr 'w' }
map { 'n', '<leader>z', 'ZZ' }
map { 'n', '<leader>Z', mapstr 'xa' }

-- No yanking --
map { '', '<leader>d', '"_d' }
map { '', '<leader>r', '"_dP' }

-- Last yanked item
map { '', '<leader>p', '"0p' }

map { 'n', '<leader>F', mapstr('utils', 'toggle_fold()') }

map { 'n', '<leader>D', mapstr 'bd' }
map { 'n', '<leader>L', mapstr 'ls' }

map { 'n', ']o', 'mzo<esc>`z' }
map { 'n', '[o', 'mzO<esc>`z' }

-- Swap : and ;
map { 'n', ':', ';' }
map { 'n', ';', ':' }
map { 'n', 'q;', 'q:' }

map { 'v', ':', ';' }
map { 'v', ';', ':' }
