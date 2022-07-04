local vorfn = function(val_or_fn)
    if type(val_or_fn) == 'function' then
        return val_or_fn()
    end

    return val_or_fn
end

local components = require 'statusline.components'

return {
    statusline = function()
        local statusline = ''

        for i = 1, #components do
            local component = components[i]

            if vorfn(component.condition) == false then
                goto continue
            end

            local prettified = '%#' .. component.highlight .. '#'
            prettified = prettified .. vorfn(component.value)

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
}
