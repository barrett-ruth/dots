local theme = require 'lualine.themes.gruvbox-material'

local shrink = function()
    return require('plenary.path'):new(vim.fn.expand '%:~'):shorten()
end

local lspname = function()
    return vim.lsp.buf_get_clients(0)[1].name or ''
end

require('lualine').setup {
    options = {
        theme = theme,
        icons_enabled = false,
        globalstatus = true,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = {
            {
                'branch',
                icons_enabled = true,
                icon = '',
            },
            {
                'diff',
                diff_color = {
                    added = { fg = 'a9b665' },
                    modified = { fg = '7daea3' },
                    removed = { fg = 'ea6962' },
                },
            },
            {
                'diagnostics',
                symbols = { error = '>', warn = '', info = ':', hint = '*' },
                diagnostics_color = {
                    error = { fg = 'ea6962' },
                    warn = { fg = 'd8a657' },
                    info = { fg = '7daea3' },
                    hint = { fg = 'a9b665' },
                },
            },
        },
        lualine_c = { shrink },
        lualine_x = { lspname, 'filetype' },
        lualine_y = { 'filesize', '%l/%L' },
        lualine_z = { 'encoding', 'bo:ff' },
    },
    inactive_sections = {
        lualine_a = { '%F' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { '%l/%L', 'encoding', 'bo:ff' },
    },
}
