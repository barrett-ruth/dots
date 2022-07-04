local utils = require 'utils'

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
            shrunk = path:new(vim.fn.expandcmd '%:~'):shorten()
        end

        return shrunk
    end,
    highlight = 'String',
}

local git = {
    value = function()
        return vim.api.nvim_eval 'FugitiveHead()'
    end,
    condition = function()
        local ok, _ = pcall(vim.api.nvim_buf_get_var, 0, 'gitsigns_head')

        return ok
    end,
    highlight = 'Operator',
    separator = 'post',
}

local line = {
    value = '%l:%L',
    highlight = 'DiagnosticInfo',
}

local macro = {
    value = function()
        return '[' .. vim.fn.reg_recording() .. ']'
    end,
    condition = function()
        return not utils.empty(vim.fn.reg_recording())
    end,
    highlight = 'DiagnosticError',
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
    highlight = 'CursorLineNr',
    separator = 'pre',
}

local right_align = {
    value = '%=',
    highlight = 'Normal',
}

local filetype = {
    value = function()
        local ft = vim.bo.ft

        if utils.empty(ft) then
            ft = vim.bo.bt
        end

        return ft
    end,
    condition = function()
        return not utils.empty(vim.bo.ft) or not utils.empty(vim.bo.bt)
    end,
    highlight = 'Number',
    separator = 'pre',
}

return {
    [1] = git,
    [2] = file,
    [3] = navic,
    [4] = right_align,
    [5] = search,
    [6] = macro,
    [7] = line,
    [8] = filetype,
}
