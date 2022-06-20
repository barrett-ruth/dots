local utils = require 'utils'

local search = {
    value = function()
        local count = vim.fn.searchcount { maxcount = 999 }

        return string.format('%s [%s/%d]', vim.fn.getreg '/', count.current, count.total)
    end,
    condition = function()
        return vim.fn.searchcount().total > 0
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
    highlight = 'YellowSign',
}

local git = {
    value = function()
        return vim.api.nvim_buf_get_var(0, 'gitsigns_head')
    end,
    condition = function()
        local ok, _ = pcall(vim.api.nvim_buf_get_var, 0, 'gitsigns_head')

        return ok
    end,
    highlight = 'OrangeSign',
    separator = 'post',
}

local line = {
    value = '%l:%L',
    highlight = 'BlueSign',
    separator = 'post'
}

local macro = {
    value = function()
        return '[' .. vim.fn.reg_recording() .. ']'
    end,
    condition = function()
        return not utils.empty(vim.fn.reg_recording())
    end,
    highlight = 'RedSign',
    separator = 'post'
}

local nvim_navic = require 'nvim-navic'
local navic = {
    value = function()
        return nvim_navic.get_location()
    end,
    condition = function()
        return nvim_navic.is_available() and not utils.empty(nvim_navic.get_location())
    end,
    highlight = 'Grey',
    separator = 'pre'
}

local right_align = {
    value = '%=',
    highlight = 'Normal'
}

local filetype = {
    value = function()
        return vim.bo.ft
    end,
    highlight = 'Purple',
}

local components = {
    [1] = git,
    [2] = file,
    [3] = navic,
    [4] = right_align,
    [5] = macro,
    [6] = search,
    [7] = line,
    [8] = filetype
}

local borfn = function(boolean_or_function)
    if type(boolean_or_function) == 'function' then
        return boolean_or_function()
    end

    return boolean_or_function
end

return {
    statusline = function()
        local statusline = ''

        for i = 1, #components do
            local component = components[i]

            if borfn(component.condition) == false then
                goto continue
            end

            local prettified = '%#' .. component.highlight .. '#'
            prettified = prettified .. borfn(component.value)

            if component.separator == 'post' then
                prettified = prettified .. '%#Normal# │ '
            elseif component.separator == 'pre' then
                prettified = '%#Normal# │ ' .. prettified
            end

            statusline = statusline .. prettified
            ::continue::
        end

        return '%#Normal# ' .. statusline .. ' '
    end,
}
