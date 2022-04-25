local theme = require 'lualine.themes.gruvbox-material'

local shrink = function()
    return require('plenary.path'):new(vim.fn.expand '%:~'):shorten()
end

local lspinfo = function()
    local statusline = require('nvim-treesitter').statusline()

    local text_len = #statusline
    local text_limit = 45
    if text_len > text_limit then
        statusline = statusline:sub(0, text_limit) .. ' ...'
    end

    return statusline
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
                symbols = { error = '>', warn = '-', info = ':', hint = '*' },
                diagnostics_color = {
                    error = { fg = 'ea6962' },
                    warn = { fg = 'd8a657' },
                    info = { fg = '7daea3' },
                    hint = { fg = 'a9b665' },
                },
            },
        },
        lualine_c = { shrink, lspinfo },
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
