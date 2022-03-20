local utils = require 'utils'
local map = utils.map
local mapstr = utils.mapstr

-- Buffers
map { 'n', ']b', mapstr 'bn' }
map { 'n', '[b', mapstr 'bp' }
map { 'n', '<leader>B', mapstr('utils', 'bd()') }

-- Builtins --
map { 'n', ':', ';' }
map { 'n', ';', ':' }
map { 'n', 'q;', 'q:' }
map { 'v', ':', ';' }
map { 'v', ';', ':' }
vim.cmd "nn <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'"
map { 'n', 'J', 'mzJ`z' }
map { 'n', 'K', 'mzkJ`z' }
map { 'v', 'J', ":m '>+1<cr>gv" }
map { 'v', 'K', ":m '<-2<cr>gv" }
map { 'n', 'Q', mapstr('utils', 'Q()') }
map { 'n', 'x', '"_x' }
map { 'n', 'zH', '15zH' }
map { 'n', 'zL', '15zL' }
map { 'n', '<bs>', '<c-^>' }
map { 'n', '<c-i>', '<c-i>zz' }
map { 'n', '<c-o>', '<c-o>zz' }

-- Centering --
map { 'n', 'G', 'Gzz' }
map { 'n', 'n', 'nzzzv' }
map { 'n', 'N', 'Nzzzv' }
map { 'n', '<c-d>', '<c-d>zz' }
map { 'n', '<c-u>', '<c-u>zz' }

-- Focusing --
map { 'n', '<c-h>', '<c-w>h' }
map { 'n', '<c-j>', '<c-w>j' }
map { 'n', '<c-k>', '<c-w>k' }
map { 'n', '<c-l>', '<c-w>l' }

-- Miscellaneous
map { 'n', '<leader><cr>', mapstr 'so %' }
map { 'n', '<leader>-', 'S<esc>' }
map { 'n', '<leader>F', ':se fdm=' }
map { 'n', '<leader>g', mapstr 'cd %:h' }
map { 'n', '<leader>k', 'K' }
map { 'n', '<leader>S', mapstr 'vert sbp' }
for _, v in ipairs { { '{', '}' }, { '(', ')' }, { '[', ']' } } do
    map { 'i', v[1] .. '<cr>', v[1] .. '<cr>' .. v[2] .. '<esc>O' }
    map { 'i', v[1] .. ',<cr>', v[1] .. '<cr>' .. v[2] .. ',<esc>O' }
end

-- Location List --
map { 'n', ']l', mapstr 'bd' .. mapstr 'lne' .. 'zz' }
map { 'n', ']L', mapstr 'lne' .. 'zz' }
map { 'n', '[l', mapstr 'lp' .. 'zz' }
map { 'n', '<leader>l', mapstr('utils', "toggle_list('l')") }
map { 'n', '<leader>L', mapstr 'cal setloclist(0, []) | sil lcl' }

-- Quickfix List --
map { 'n', ']c', mapstr 'bd' .. mapstr 'cne' .. 'zz' }
map { 'n', ']C', mapstr 'cn' .. 'zz' }
map { 'n', '[c', mapstr 'cp' .. 'zz' }
map { 'n', '<leader>c', mapstr('utils', "toggle_list('c')") }
map { 'n', '<leader>C', mapstr 'cal setqflist([]) | sil ccl' }

-- Newlines --
map { 'n', ']o', '@="m`o\\eg``"<cr>' }
map { 'n', '[o', '@="m`O\\eg``"<cr>' }

-- Pasting --
map { '', '<leader>p', '"0p' }

-- Resizing --
map { 'n', '<c-left>', mapstr 'vert resize -10' }
map { 'n', '<c-down>', mapstr 'resize +10' }
map { 'n', '<c-up>', mapstr 'resize -10' }
map { 'n', '<c-right>', mapstr 'vert resize +10' }

-- Saving/exiting --
map { 'n', '<leader>q', mapstr 'q' }
map { 'n', '<leader>Q', mapstr 'q!' }
map { 'n', '<leader>w', mapstr 'w' .. mapstr('utils', 'save()') }
map { 'n', '<leader>W', mapstr 'wa' }
map { 'n', '<leader>z', 'ZZ' }
map { 'n', '<leader>Z', mapstr 'xa' }

-- Swaplines --
map { 'n', '[e', '@="m`:m-2\\eg``"<cr>' }
map { 'n', ']e', '@="m`:m+\\eg``"<cr>' }

-- Toggling --
map { 'n', '<leader>iw', mapstr('utils', "invert_opt 'wrap'") }
map { 'n', '<leader>is', mapstr('utils', "invert_opt('spell', true)") }

-- Yanking --
map { '', '<leader>y', '"+y' }
map { '', '<leader>Y', mapstr '%y"' }

-- Disabling yanking --
map { '', '<leader>d', '"_d' }
map { '', '<leader>r', '"_dP' }
