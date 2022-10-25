local gruvbox = require 'gruvbox'
local cs, hi = gruvbox.cs, gruvbox.hi

hi('pythonInclude', { italic = true, fg = cs.purple })
hi('pythonConstructor', { fg = cs.green })

vim.opt.iskeyword:append '_'
