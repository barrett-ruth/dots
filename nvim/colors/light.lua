local colors = require('colors')
colors.setup(vim.env.THEME, 'light')

local hi, link, tshi, cs =
    colors.hi, colors.link, colors.tshi, colors[vim.g.colors_name]

hi(
    'Normal',
    { fg = cs.black, bg = cs.white },
    { 'Identifier', 'Special', 'StatusLine', 'StatusLineNC' }
)
