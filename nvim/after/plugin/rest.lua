local rest = require 'rest-nvim'

rest.setup {
    highlight = {
        enabled = false,
    },
    yank_dry_run = false,
}

local utils = require 'utils'

utils.map { 'n', '<leader>R', rest.run }
