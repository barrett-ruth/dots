local theme = require 'lualine.themes.gruvbox'
theme.inactive.a.gui = 'NONE'

require('lualine').setup {
    options = {
        theme = theme,
        icons_enabled = false,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = {
            'branch',
            'diff',
            { 'diagnostics', symbols = { error = '>', warn = '-', info = ':', hint = '*' } },
        },
        lualine_c = { { '%F', file_status = true, path = 1 } },
        lualine_x = { 'filetype' },
        lualine_y = { 'filesize', '%l/%L' },
        lualine_z = { 'encoding', 'bo:ff' },
    },
    inactive_sections = {
        lualine_a = { { '%F', path = 1 } },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { '%l/%L', 'encoding', 'bo:ff' },
    },
}
