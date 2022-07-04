local utils = require 'utils'
local map = utils.map

map { 'n', '<leader>th', utils.mapstr 'TSHighlightCapturesUnderCursor' }

for k, v in pairs {
    a = '@parameter.inner',
    c = '@call.outer',
    C = '@class.outer',
    f = '@function.outer',
    i = '@conditional.outer',
} do
    map({
        'n',
        ']' .. k,
        [[':<c-u>lua require("paqs.treesitter.map").next("]]
            .. v
            .. [[", ' . v:count1 . ')<cr>']],
    }, { expr = true })
    map({
        'n',
        '[' .. k,
        [[':<c-u>lua require("paqs.treesitter.map").previous("]]
            .. v
            .. [[", ' . v:count1 . ')<cr>']],
    }, { expr = true })
end

return {
    next = function(type, count)
        for _ = 1, count do
            require('nvim-treesitter.textobjects.move').goto_next_start(type)
        end
    end,
    previous = function(type, count)
        for _ = 1, count do
            require('nvim-treesitter.textobjects.move').goto_previous_start(
                type
            )
        end
    end,
}
