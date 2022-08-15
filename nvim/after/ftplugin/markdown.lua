local utils = require 'utils'

utils.map { 'n', '<leader>m', utils.mapstr 'MarkdownPreviewToggle' }

local cs, hi = utils.cs, utils.hi

hi('markdownTSTitle', { fg = cs.orange })

vim.o.spell = false
vim.o.shiftwidth = 2
vim.o.conceallevel = 1
