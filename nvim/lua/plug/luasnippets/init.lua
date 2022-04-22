local ls = require 'luasnip'

local types = require 'luasnip.util.types'

ls.config.set_config {
    delete_check_events = 'TextChanged,TextChangedI,InsertLeave',
    update_events = 'TextChanged,TextChangedI,InsertLeave',
    history = true,
    ext_opts = { [types.choiceNode] = { active = { virt_text = { { ' <- ', 'Normal' } } } } },
}

local s = ls.s
local t = ls.t
local i = ls.i

local function snipopts(trig)
    return { trig = trig, wordTrig = false }
end

local inline = function(lr)
    return s(snipopts(lr[1]), { t(lr[1]), i(1), t(lr[2]) })
end

local newline = function(lr)
    return s(snipopts(lr[2]), { t(lr[1]), i(1), t { '', '' }, t(lr[2]) })
end

local acc = {}

for _, v in ipairs { { '({', '})' }, { '[[', ']]' } } do
    table.insert(acc, inline(v))
    table.insert(acc, newline(v))
end

for _, v in ipairs { { '{', '}' }, { '(', ')' }, { '[', ']' } } do
    table.insert(acc, inline(v))
    table.insert(acc, inline({ v[1] .. ' ', ' ' .. v[2] }))
    table.insert(acc, inline({ v[1] .. "'", "'" .. v[2] }))
    table.insert(acc, newline(v))
    table.insert(acc, newline({ v[1], v[2] .. ',' }))
end

for _, v in ipairs { { '"', '"' }, { "'", "'" }, { '<', '>' }, { '`', '`' } } do
    table.insert(acc, inline(v))
end

ls.add_snippets(nil, { all = acc })
require('luasnip.loaders.from_lua').lazy_load { paths = '~/.config/nvim/lua/plug/luasnippets' }

local utils = require 'utils'
local map = utils.map
local mapstr = utils.mapstr

map { { 'i', 's' }, '<c-h>', mapstr "lua ls = require 'luasnip'; if ls.jumpable(-1) then ls.jump(-1) end" }
map { { 'i', 's' }, '<c-l>', mapstr "lua ls = require 'luasnip'; if ls.jumpable(1) then ls.jump(1) end" }

map { 'i', '<c-s>', mapstr "lua ls = require 'luasnip'; if ls.expandable() then ls.expand() end" }
map { 'i', '<c-j>', mapstr "lua ls = require 'luasnip'; if ls.choice_active() then ls.change_choice(-1) end" }
map { 'i', '<c-k>', mapstr "lua ls = require 'luasnip'; if ls.choice_active() then ls.change_choice(1) end" }
