local utils = require 'utils'

utils.map({ 'n', '<leader>db', ':DB ' }, { silent = false })
utils.map { 'n', '<leader>du', utils.mapstr 'DBUIToggle' }
