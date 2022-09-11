local vorfn = require('utils').vorfn
local components = {
    [1] = {
        value = function()
            local expanded = vim.fn.expand '%:p'
            local shrunk = expanded

            if vim.startswith(expanded, vim.env.HOME) then
                local path = require 'plenary.path'
                shrunk = path:new(vim.fn.expand '%:~'):shorten()
            end

            return shrunk
        end,
        highlight = 'String',
    },
}

return {
    winbar = function()
        local wbr = ''

        for i = 1, #components do
            local component = components[i]

            local prettified = '%#' .. component.highlight .. '#'
            prettified = prettified .. vorfn(component.value)

            wbr = wbr .. prettified
        end

        return '%#Normal# ' .. wbr .. ' '
    end,
}
