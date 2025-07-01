local utils = require('utils')

local M = {}

local function vorfn(val_or_fn)
    if type(val_or_fn) == 'function' then
        return val_or_fn()
    end

    return val_or_fn
end

function M.format_components(components)
    local side = {}

    for i = 1, #components do
        local component = components[i]

        -- local highlight = component.highlight or 

        if
            vorfn(component.condition) ~= false
            and not utils.empty(vorfn(component.value))
        then
            side[#side + 1] = vorfn(component.value)
        end
    end

    return ' ' .. table.concat(side, ' ')
end

return M
