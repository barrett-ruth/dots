local theme = require 'lualine.themes.gruvbox-material'
theme.inactive.a.gui = 'NONE'

local shrink = function()
    local dir = vim.fn.expand '%:~'
    local file = vim.fn.expand '%:t'
    local tree = vim.split(dir, '/')
    local out = ''

    if tree[1] == '~' then
        out = '~'
        table.remove(tree, 1)
    else
        return vim.fn.expand '%:p'
    end

    for _, e in ipairs(tree) do
        if e == file then
            out = out .. '/' .. file
            break
        end

        local letter = e:sub(1, 1)
        out = out .. '/' .. letter
        if letter == '.' then
            out = out .. e:sub(2, 2)
        end
    end

    return out
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
        lualine_c = { shrink },
        lualine_x = { 'filetype' },
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
