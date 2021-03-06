local utils = require 'utils'
local map, mapstr = utils.map, utils.mapstr

map { 'n', '<leader>ha', mapstr('harpoon.mark', 'add_file()') }
map { 'n', '<leader>hd', mapstr('harpoon.mark', 'rm_file()') }
map { 'n', '<leader>hq', mapstr('harpoon.ui', 'toggle_quick_menu()') }
map { 'n', '<leader>hh', mapstr('harpoon.ui', 'nav_file(1)') }
map { 'n', '<leader>hj', mapstr('harpoon.ui', 'nav_file(2)') }
map { 'n', '<leader>hk', mapstr('harpoon.ui', 'nav_file(3)') }
map { 'n', '<leader>hl', mapstr('harpoon.ui', 'nav_file(4)') }
map { 'n', '<leader>hn', mapstr('harpoon.ui', 'nav_next()') }
map { 'n', '<leader>hp', mapstr('harpoon.ui', 'nav_prev()') }
