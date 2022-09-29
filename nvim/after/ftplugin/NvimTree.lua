local utils = require 'utils'

utils.bmap {
    'n',
    'v',
    function()
        require('nvim-tree.api').node.open.edit()
        vim.cmd 'bp|vert sbp'
    end,
}
