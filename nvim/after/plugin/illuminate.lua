require('illuminate').configure {
    delay = 0,
    providers = {
        'treesitter',
        'lsp',
        'regex',
    },
}

local utils = require 'utils'
utils.map { 'n', '<leader>ii', utils.mapstr('illuminate', 'toggle_buf()') }
