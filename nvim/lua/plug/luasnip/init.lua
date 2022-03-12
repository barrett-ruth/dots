local ls = require 'luasnip'

ls.config.set_config { updateevents = 'TextChanged,TextChangedI' }

local s = ls.s
local t = ls.t
local i = ls.i

local function snipopts(trig)
    return { trig = trig, wordTrig = false }
end

local simple = function(lr)
    return s(snipopts(lr[1]), {
        t(lr[1]),
        i(1),
        t(lr[2]),
    })
end

local inline = function(trig, lr, comma)
    return s(snipopts(trig), {
        t(lr[1] .. ' '),
        i(1),
        t(' ' .. lr[2] .. comma),
    })
end

local newline = function(trig, lr, comma)
    return s(snipopts(trig), {
        t(lr[1]),
        t { '', '    ' },
        i(1),
        t { '', '' },
        t(lr[2] .. comma),
    })
end

local acc = {}
for _, v in ipairs { { '{', '}' }, { '(', ')' }, { '[', ']' } } do
    table.insert(acc, newline(v[1] .. 'n', v, ''))
    table.insert(acc, newline(v[1] .. ',', v, ','))
    table.insert(acc, inline(v[1] .. ' ', v, ''))
    table.insert(acc, inline(v[1] .. ' ,', v, ','))
    table.insert(acc, simple(v))
end
for _, v in ipairs { { '"', '"' }, { "'", "'" }, { '<', '>' } } do
    table.insert(acc, simple(v))
end

ls.snippets = { all = acc }

ls.filetype_extend('bash', { 'sh' })
ls.filetype_extend('zsh', { 'sh' })
ls.filetype_extend('cpp', { 'c' })
ls.filetype_extend('javascriptreact', { 'javascript' })
ls.filetype_extend('typescript', { 'javascript' })
ls.filetype_extend('typescriptreact', { 'javascript' })

local utils = require 'utils'
local map = utils.map
local mapstr = utils.mapstr

map { 'i', '<c-s>', mapstr "lua ls = require 'luasnip'; if ls.expandable() then ls.expand() end" }
map { 'i', '<c-f>', mapstr "lua ls = require 'luasnip'; if ls.jumpable(1) then ls.jump(1) end" }
map { 'i', '<c-b>', mapstr "lua ls = require 'luasnip'; if ls.jumpable(-1) then ls.jump(-1) end" }
