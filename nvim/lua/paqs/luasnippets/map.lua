local utils = require 'utils'
local map = utils.map
local ls = require 'luasnip'

map {
    { 'i', 's' },
    '<c-h>',
    function()
        if ls.jumpable(-1) then ls.jump(-1) end
    end,
}
map {
    { 'i', 's' },
    '<c-l>',
    function()
        if ls.jumpable(1) then ls.jump(1) end
    end,
}

map {
    'i',
    '<c-s>',
    function()
        if ls.expandable() then ls.expand() end
    end,
}
map {
    'i',
    '<c-j>',
    function()
        if ls.choice_active() then
            ls.change_choice(-1)
        else
            vim.cmd.norm 'j'
        end
    end,
}
map {
    'i',
    '<c-k>',
    function()
        if ls.choice_active() then
            ls.change_choice(1)
        else
            vim.cmd.norm 'k'
        end
    end,
}
