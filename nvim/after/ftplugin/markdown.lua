local utils = require 'utils'

utils.map { 'n', '<leader>m', utils.mapstr 'MarkdownPreviewToggle' }

local gruvbox = require 'gruvbox'
local cs, hi = gruvbox.cs, gruvbox.hi

hi('markdownTitle', { fg = cs.orange })

vim.o.conceallevel = 1
