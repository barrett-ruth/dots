local colors = require('colors')
local cs = colors[vim.g.colors_name]

if cs and vim.g.colors_name == 'gruvbox' then
    colors.hi('@constructor.lua', { fg = cs.white })
end
