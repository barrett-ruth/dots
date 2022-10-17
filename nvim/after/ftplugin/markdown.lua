local utils = require 'utils'

utils.map { 'n', '<leader>m', utils.mapstr 'MarkdownPreviewToggle' }

local cs, hi = utils.cs, utils.hi

hi('markdownTitle', { fg = cs.orange })
hi('markdownUrl', { fg = cs.blue, italic = true })

vim.opt.shiftwidth = 2
vim.opt.conceallevel = 1
