require('harpoon').setup {}

local utils = require 'utils'
local map = utils.map
local mapstr = utils.mapstr

local harpoonleader = '<leader>h'

map { 'n', harpoonleader .. 'a', mapstr('harpoon.mark', 'add_file()') }
map { 'n', harpoonleader .. 'd', mapstr('harpoon.mark', 'rm_file()') }
map { 'n', harpoonleader .. 'q', mapstr('harpoon.ui', 'toggle_quick_menu()') }
map { 'n', harpoonleader .. 'h', mapstr('harpoon.ui', 'nav_file(1)') }
map { 'n', harpoonleader .. 'j', mapstr('harpoon.ui', 'nav_file(2)') }
map { 'n', harpoonleader .. 'k', mapstr('harpoon.ui', 'nav_file(3)') }
map { 'n', harpoonleader .. 'l', mapstr('harpoon.ui', 'nav_file(4)') }
