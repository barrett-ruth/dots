local M = {}

local ok, nvim_navic = pcall(require, 'nvim-navic')

local navic = {
    -- highlight = 'grey',
    condition = function()
        return ok
            and nvim_navic.is_available()
            and not require('utils').empty(nvim_navic.get_location())
    end,
    value = function()
        return require('nvim-navic').get_location()
    end,
}

local winbar = {
    [1] = navic,
}

local format_components = require('lines.utils').format_components

M.winbar = function()
    return format_components(winbar)
end

return M
