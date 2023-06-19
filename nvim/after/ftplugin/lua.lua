local colors = require('colors')
local cs = colors[vim.g.colors_name]

if not cs then
    return
end

if vim.g.colors_name == 'gruvbox' then
    colors.hi('@constructor.lua', { fg = cs.white })
else
    colors.hi('@constructor.lua', { fg = cs.black })
end
