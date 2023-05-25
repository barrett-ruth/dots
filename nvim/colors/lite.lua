local colors = require('colors')
colors.setup('lite')

local hi, link, cs = colors.hi, colors.link, colors[vim.g.colors_name]

-- basic colors
hi('Red', { fg = cs.red })
hi('Orange', { fg = cs.orange })
hi('Yellow', { fg = cs.yellow })
hi('Green', { fg = cs.green })
hi('Cyan', { fg = cs.cyan })
hi('Blue', { fg = cs.blue })
hi('Purple', { fg = cs.purple })
hi('Grey', { fg = cs.grey })
hi('White', { fg = cs.white })
hi('Black', { fg = cs.black })

-- basic ui
hi('Normal', { fg = cs.white, bg = cs.bg })
hi('NonText', { fg = cs.black })
