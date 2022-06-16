local current_lsp = function()
    return vim.lsp.get_active_clients({ bufnr = 0 })[1]
end

local path = function()
    local expanded = vim.fn.expand '%:p'
    local shrunk = expanded

    if vim.startswith(expanded, vim.env.HOME) then
        local path = require 'plenary.path'
        shrunk = path:new(vim.fn.expand '%:~'):shorten()
    end

    return shrunk
end

local search_count = function()
    local count = vim.fn.searchcount { maxcount = 999 }

    if count.total > 0 then
        return string.format('%s [%s/%d]', vim.fn.getreg '/', count.current, count.total)
    else
        return ''
    end
end

local macro = function()
    return vim.fn.reg_recording()
end

local navic = require 'nvim-navic'

require('lualine').setup {
    options = {
        component_separators = { left = '│', right = '│' },
        section_separators = { left = '', right = '' },
        icons_enabled = false,
        globalstatus = true,
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
        },
        lualine_c = { path },
        lualine_x = {
            {
                macro,
                cond = function()
                    return not require('utils').empty(macro())
                end,
            },
            search_count,
        },
        lualine_y = { '%l/%L', 'filesize' },
        lualine_z = { 'filetype' },
    },
    winbar = {
        lualine_a = {
            {
                function()
                    return current_lsp().name
                end,
                cond = function()
                    return current_lsp() ~= nil
                end,
            },
        },
        lualine_b = {
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
            { navic.get_location, cond = navic.is_available },
        },
    },
    inactive_winbar = {
        lualine_a = { path },
    },
}
