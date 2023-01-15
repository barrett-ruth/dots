local M = {}

local function vorfn(val_or_fn)
    if type(val_or_fn) == 'function' then
        return val_or_fn()
    end

    return val_or_fn
end

local function format_component(component)
    return '%#Grey#' .. vorfn(component.value)
end

function M.format_components(components)
    local side = {}

    for i = 1, #components do
        local component = components[i]

        if vorfn(component.condition) ~= false then
            table.insert(side, format_component(component))
        end
    end

    return ' ' .. table.concat(side, '%#Normal# │ ') .. ' '
end

return M
