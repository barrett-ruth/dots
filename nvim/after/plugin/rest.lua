require('rest-nvim').setup {
    highlight = {
        enabled = false,
    },
    yank_dry_run = false,
}

local utils = require 'utils'

utils.map { 'n', '<leader>R', utils.mapstr('rest-nvim', 'run()') }
