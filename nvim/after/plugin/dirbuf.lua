require('dirbuf').setup {
    sort_order = 'directories_first',
}

local utils = require 'utils'
local map, mapstr = utils.map, utils.mapstr

map { 'n', '<c-e>', mapstr 'e .' }
map {
    'n',
    '<leader>e',
    function() vim.cmd('e ' .. vim.fn.expand '%:p:h') end,
}
