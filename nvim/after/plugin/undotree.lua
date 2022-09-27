local utils = require 'utils'

utils.map { 'n', '<leader>u', utils.mapstr 'UndotreeToggle' }

vim.g.undotree_HelpLine = 0
vim.g.undotree_ShortIndicators = 1
