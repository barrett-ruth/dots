local utils = require 'utils'

local cs = vim.g.colors_name == 'gruvbox-material'

local search = {
    value = function()
        local count = vim.fn.searchcount { maxcount = 999 }

        return string.format(
            '%s [%s/%d]',
            vim.fn.getreg '/',
            count.current,
            count.total
        )
    end,
    condition = function()
        local searchcount = vim.fn.searchcount()
        return next(searchcount) and searchcount.total > 0
    end,
    highlight = 'Normal',
    separator = 'post',
}

local file = {
    value = function()
        local expanded = vim.fn.expand '%:p'
        local shrunk = expanded

        if vim.startswith(expanded, vim.env.HOME) then
            local path = require 'plenary.path'
            shrunk = path:new(vim.fn.expand '%:~'):shorten()
        end

        return shrunk
    end,
    highlight = cs and 'YellowSign' or 'Function',
}

local git = {
    value = function()
        return vim.api.nvim_buf_get_var(0, 'gitsigns_head')
    end,
    condition = function()
        local ok, _ = pcall(vim.api.nvim_buf_get_var, 0, 'gitsigns_head')

        return ok
    end,
    highlight = cs and 'OrangeSign' or 'Statement',
    separator = 'post',
}

local line = {
    value = '%l:%L',
    highlight = cs and 'BlueSign' or 'Character',
    separator = 'post',
}

local macro = {
    value = function()
        return '[' .. vim.fn.reg_recording() .. ']'
    end,
    condition = function()
        return not utils.empty(vim.fn.reg_recording())
    end,
    highlight = cs and 'RedSign' or 'WarningMsg',
    separator = 'post',
}

local nvim_navic = require 'nvim-navic'
local navic = {
    value = function()
        return nvim_navic.get_location()
    end,
    condition = function()
        return nvim_navic.is_available()
            and not utils.empty(nvim_navic.get_location())
    end,
    highlight = cs and 'Grey' or 'Ignore',
    separator = 'pre',
}

local right_align = {
    value = '%=',
    highlight = 'Normal',
}

local filetype = {
    value = function()
        return vim.bo.ft
    end,
    highlight = cs and 'Purple' or 'Number',
}

return {
    [1] = git,
    [2] = file,
    [3] = navic,
    [4] = right_align,
    [5] = macro,
    [6] = search,
    [7] = line,
    [8] = filetype,
}
