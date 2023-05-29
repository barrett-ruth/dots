local colors = require('colors')
local cs = colors[vim.g.colors_name]

if vim.g.colors_name == 'gruvbox' then
    colors.hi('@constructor.lua', { fg = cs.white })
elseif vim.g.colors_name == 'lite' then
    colors.hi('@constructor.lua', { fg = cs.black })
end
