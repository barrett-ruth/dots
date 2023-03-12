vim.o.shiftwidth = 2

local colors = require 'colors'

local cs = colors[vim.g.colors_name]

colors.hi('@text.title.html', { fg = cs.black })
