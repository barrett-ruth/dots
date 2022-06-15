local lspname = function()
    return vim.lsp.buf_get_clients(0)[1].name or ''
end

local path = function()
    local path = require 'plenary.path'
    return path:new(vim.fn.expand '%:~'):shorten()
end

local search_count = function()
    local count = vim.fn.searchcount()

    if count.total > 0 then
        return string.format('%s [%s/%d]', vim.fn.getreg '/', count.current, count.total)
    else
        return ''
    end
end

local navic = require 'nvim-navic'

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
        lualine_c = {
            { path },
            { navic.get_location, cond = navic.is_available },
        },
        lualine_x = { search_count, lspname },
        lualine_y = { 'filetype', 'filesize' },
        lualine_z = { 'encoding', 'bo:ff' },
    },
}
