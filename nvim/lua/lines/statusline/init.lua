local components = require 'lines.statusline.components'

local format_components = require('lines.utils').format_components

return {
    statusline = function()
        return (' %s%%=%s '):format(
            format_components(components.left),
            format_components(components.right)
        )
    end,
}
