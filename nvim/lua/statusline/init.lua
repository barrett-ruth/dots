local borfn = function(boolean_or_function)
    if type(boolean_or_function) == 'function' then
        return boolean_or_function()
    end

    return boolean_or_function
end

local components = require 'statusline.components'

local M = {}
M.statusline = function()
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
end

return M
