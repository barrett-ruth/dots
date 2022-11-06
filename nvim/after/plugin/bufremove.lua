local bufremove = require 'mini.bufremove'
bufremove.setup {}

map { 'n', '<leader>bd', bufremove.delete }
map { 'n', '<leader>bw', bufremove.wipeout }
