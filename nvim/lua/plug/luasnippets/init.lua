local ls = require 'luasnip'

local types = require 'luasnip.util.types'

ls.config.set_config {
    delete_check_events = 'TextChanged,TextChangedI,InsertLeave',
    update_events = 'TextChanged,TextChangedI,InsertLeave',
    history = true,
    ext_opts = {
        [types.choiceNode] = {
            active = { virt_text = { { ' <- ', vim.wo.cursorline and 'CursorLine' or 'Normal' } } },
        },
    },
}

local i, s, t = ls.i, ls.s, ls.t

local function snipopts(trig)
    return { trig = trig, wordTrig = false }
end

local inline = function(lr)
    local trig = lr[1]

    if trig:len() == 3 then
        lr[2] = lr[2] .. trig:sub(3, 3)
        lr[1] = trig:sub(1, 2)
    elseif lr[1]:sub(2, 2) == "'" or lr[1]:sub(2, 2) == '"' then
        return s(snipopts(trig), { t(lr[1]), i(1), t(lr[2]:sub(1, 1)), i(2), t(lr[2]:sub(2, 2)) })
    end

    return s(snipopts(trig), { t(lr[1]), i(1), t(lr[2]) })
end

local newline = function(lr)
    if lr[2]:sub(1, 1) == '}' then
        return s(
            snipopts(lr[2]),
            { t(lr[1]), t { '', '\t' }, i(1), t { '', '' }, t(lr[2]:sub(1, 1)), i(2), t(lr[2]:sub(2, 2)) }
        )
    end

    return s(snipopts(lr[2]), { t(lr[1]), t { '', '\t' }, i(1), t { '', '' }, t(lr[2]) })
end

local acc = {}

for _, v in ipairs { { '({', '})' }, { '[[', ']]' } } do
    table.insert(acc, inline(v))
    table.insert(acc, newline(v))
end

for _, v in ipairs { { '{', '}' }, { '(', ')' }, { '[', ']' } } do
    table.insert(acc, inline(v))
    table.insert(acc, inline { v[1] .. ' ', ' ' .. v[2] })
    table.insert(acc, inline { v[1] .. ' ,', ' ' .. v[2] })
    table.insert(acc, inline { v[1] .. "'", "'" .. v[2] })
    table.insert(acc, inline { v[1] .. '"', '"' .. v[2] })
    table.insert(acc, newline(v))
    table.insert(acc, newline { v[1], v[2] .. ',' })
end

ls.add_snippets(nil, { all = acc })
require('luasnip.loaders.from_lua').lazy_load { paths = '~/.config/nvim/lua/plug/luasnippets' }

local utils = require 'utils'
local map = utils.map

map {
    { 'i', 's' },
    '<c-h>',
    function()
        if ls.jumpable(-1) then
            ls.jump(-1)
        end
    end,
}
map {
    { 'i', 's' },
    '<c-l>',
    function()
        if ls.jumpable(1) then
            ls.jump(1)
        end
    end,
}

map {
    'i',
    '<c-s>',
    function()
        if ls.expandable() then
            ls.expand()
        end
    end,
}
map {
    'i',
    '<c-j>',
    function()
        if ls.choice_active() then
            ls.change_choice(-1)
        end
    end,
}
map {
    'i',
    '<c-k>',
    function()
        if ls.choice_active() then
            ls.change_choice(1)
        end
    end,
}
