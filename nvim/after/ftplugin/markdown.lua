local utils = require 'utils'

utils.map { 'n', '<leader>m', utils.mapstr 'MarkdownPreviewToggle' }

local cs, hi = utils.cs, utils.hi

hi('markdownTSTitle', { fg = cs.orange })

vim.opt.spell = false
vim.opt.shiftwidth = 2
vim.opt.conceallevel = 1
