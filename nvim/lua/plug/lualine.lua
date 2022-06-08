local lspname = function()
    return vim.lsp.buf_get_clients(0)[1].name or ''
end

require('lualine').setup {
    options = {
        component_separators = { left = '│', right = '│' },
        section_separators = { left = '', right = '' },
        icons_enabled = false,
        globalstatus = true,
        theme = 'gruvbox-material',
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = {
            'branch',
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
                diagnostics_color = {
                    error = { fg = 'ea6962' },
                    warn = { fg = 'd8a657' },
                    info = { fg = '7daea3' },
                    hint = { fg = 'a9b665' },
                },
                symbols = {
                    error = '>',
                    warn = '—',
                    info = ':',
                    hint = '*',
                },
                update_in_insert = true,
            },
        },
        lualine_c = { '%F' },
        lualine_x = { lspname, 'filetype' },
        lualine_y = { 'filesize', '%l/%L' },
        lualine_z = { 'encoding', 'bo:ff' },
    },
}
