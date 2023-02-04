local path = {
    value = function()
        local expanded = vim.fn.expand '%:p'
        local shrunk = expanded

        local fpath = require 'plenary.path'
        shrunk = fpath:new(vim.fn.expand '%:~'):shorten()

        return shrunk
    end,
}

local navic = {
    condition = function()
        local ok, nvim_navic = pcall(require, 'nvim-navic')

        return ok
            and nvim_navic.is_available()
            and not require('utils').empty(nvim_navic.get_location())
    end,
    value = function()
        return require('nvim-navic').get_location()
    end,
}

local winbar = {
    [1] = path,
    [2] = navic,
}

local format_components = require('lines.utils').format_components

return {
    winbar = function()
        return format_components(winbar)
    end,
}
