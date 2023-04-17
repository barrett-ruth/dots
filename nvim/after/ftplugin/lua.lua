local colors = require 'colors'
local cs = colors[vim.g.colors_name]

colors.hi('@constructor.lua', { fg = cs.white })
colors.link('@variable', '@lsp.type.variable')
colors.link('@parameter', '@lsp.type.parameter')
colors.link('@field', '@lsp.type.property')
colors.hi('@lsp.type.comment', { none = true })
