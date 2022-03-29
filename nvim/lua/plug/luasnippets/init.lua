local ls = require 'luasnip'
local types = require 'luasnip.util.types'

ls.config.set_config {
    updateevents = 'TextChanged,TextChangedI',
    history = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { ' <- ', 'CursorLine' } },
            },
        },
    },
}

local s = ls.s
local t = ls.t
local i = ls.i

local function snipopts(trig)
    return { trig = trig, wordTrig = false }
end

local inline = function(trig, lr, space, comma)
    return s(snipopts(trig), {
        t(lr[1] .. space),
        i(1),
        t(space .. lr[2] .. comma),
    })
end

local newline = function(trig, lr, comma)
    return s(snipopts(trig), {
        t(lr[1]),
        t { '', '\t' },
        i(1),
        t { '', '' },
        t(lr[2] .. (comma or '')),
    })
end

local acc = {}

for _, v in ipairs { { '{', '}' }, { '(', ')' }, { '[', ']' } } do
    table.insert(acc, inline(v[1] .. ' ', v, ' ', ''))
    table.insert(acc, inline(v[1] .. ',', v, '', ','))
    table.insert(acc, inline(v[1] .. ' ,', v, ' ', ','))
    table.insert(acc, inline(v[1], v, '', ''))
    table.insert(acc, newline(v[1] .. 'n,', v, ','))
    table.insert(acc, newline(v[1] .. 'n', v))
end
for _, v in ipairs { { '"', '"' }, { "'", "'" }, { '<', '>' } } do
    table.insert(acc, inline(v[1], v, '', ''))
    table.insert(acc, inline(v[1] .. ',', v, '', ','))
    table.insert(acc, inline(v[1] .. ', ', v, '', ', '))
end

ls.add_snippets(nil, { all = acc })
require('luasnip.loaders.from_lua').lazy_load({ paths = '~/.config/nvim/lua/plug/luasnippets' })

local utils = require 'utils'
local map = utils.map
local mapstr = utils.mapstr

map { 'i', '<c-h>', mapstr "lua ls = require 'luasnip'; if ls.jumpable(-1) then ls.jump(-1) end" }
map { 's', '<c-h>', mapstr "lua ls = require 'luasnip'; if ls.jumpable(-1) then ls.jump(-1) end" }

map { 'i', '<c-l>', mapstr "lua ls = require 'luasnip'; if ls.jumpable(1) then ls.jump(1) end" }
map { 's', '<c-l>', mapstr "lua ls = require 'luasnip'; if ls.jumpable(1) then ls.jump(1) end" }

map { 'i', '<c-s>', mapstr "lua ls = require 'luasnip'; if ls.expandable() then ls.expand() end" }
map { 'i', '<c-j>', mapstr "lua ls = require 'luasnip'; if ls.choice_active() then ls.change_choice(-1) end" }
map { 'i', '<c-k>', mapstr "lua ls = require 'luasnip'; if ls.choice_active() then ls.change_choice(1) end" }
