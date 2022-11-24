local winbar = require 'lines.winbar'
local statusline = require 'lines.statusline'

local format_components = require('lines.utils').format_components

return {
    setup = function()
        vim.o.winbar = format_components(winbar)
        vim.o.statusline = ('%s%%=%s'):format(
            format_components(statusline.left),
            format_components(statusline.right)
        )
    end,
}
