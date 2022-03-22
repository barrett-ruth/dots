local ls = require 'luasnip'

ls.config.set_config { updateevents = 'TextChanged,TextChangedI' }

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

local acc = {}

for _, v in ipairs { { '{', '}' }, { '(', ')' }, { '[', ']' } } do
    table.insert(acc, inline(v[1] .. ' ', v, ' ', ''))
    table.insert(acc, inline(v[1] .. ',', v, '', ','))
    table.insert(acc, inline(v[1] .. ' ,', v, ' ', ','))
    table.insert(acc, inline(v[1], v, '', ''))
end
for _, v in ipairs { { '"', '"' }, { "'", "'" }, { '<', '>' } } do
    table.insert(acc, inline(v[1], v, '', ''))
    table.insert(acc, inline(v[1] .. ',', v, '', ', '))
end

ls.snippets = { all = acc }

local utils = require 'utils'
local map = utils.map
local mapstr = utils.mapstr

map { 'i', '<c-b>', mapstr "lua ls = require 'luasnip'; if ls.jumpable(-1) then ls.jump(-1) end" }
map { 'i', '<c-f>', mapstr "lua ls = require 'luasnip'; if ls.jumpable(1) then ls.jump(1) end" }
map { 's', '<c-b>', mapstr "lua ls = require 'luasnip'; if ls.jumpable(-1) then ls.jump(-1) end" }
map { 's', '<c-f>', mapstr "lua ls = require 'luasnip'; if ls.jumpable(1) then ls.jump(1) end" }
map { 'i', '<c-s>', mapstr "lua ls = require 'luasnip'; if ls.expandable() then ls.expand() end" }
