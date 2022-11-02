local fn = vim.fn

local utils = require 'utils'

local search = {
    value = function()
        local count = fn.searchcount { maxcount = 999 }

        return ('%s [%s/%d]'):format(fn.getreg '/', count.current, count.total)
    end,
    condition = function()
        local status, searchcount = pcall(fn.searchcount)
        if not status then return false end

        return searchcount.total > 0
    end,
    highlight = 'Normal',
    separator = 'post',
}

local file = {
    value = '%f',
    highlight = 'String',
}

local git = {
    value = function() return vim.b.gitsigns_head end,
    condition = function() return not utils.empty(vim.b.gitsigns_head) end,
    highlight = 'Operator',
    separator = 'post',
}

local line = {
    value = '%l:%L',
    highlight = 'DiagnosticInfo',
}

local macro = {
    value = function() return '[' .. fn.reg_recording() .. ']' end,
    condition = function() return not utils.empty(fn.reg_recording()) end,
    highlight = 'DiagnosticError',
    separator = 'post',
}

local right_align = {
    value = '%=',
    highlight = 'Normal',
}

local filetype = {
    value = function()
        local ft = vim.bo.ft

        if utils.empty(ft) then ft = vim.bo.bt end

        return ft
    end,
    condition = function()
        return not utils.empty(vim.bo.ft) or not utils.empty(vim.bo.bt)
    end,
    highlight = 'Number',
    separator = 'pre',
}

local fileinfo = {
    value = function() return ('%s[%s]'):format(vim.bo.fileencoding, vim.bo.fileformat) end,
    highlight = 'Function',
    separator = 'pre',
}

return {
    [1] = git,
    [2] = file,
    [3] = right_align,
    [4] = search,
    [5] = macro,
    [6] = line,
    [7] = filetype,
    [8] = fileinfo,
}
