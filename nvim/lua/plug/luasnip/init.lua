local ls = require 'luasnip'

ls.config.set_config { updateevents = 'TextChanged,TextChangedI' }

local s = ls.s
local t = ls.t
local i = ls.i

local function snipopts(trig)
    return { trig = trig, wordTrig = false }
end

local newline = function(v, prefix, comma)
    return s(snipopts(v[1] .. prefix), {
        t(v[1]),
        t { '', '    ' },
        i(1),
        t { '', '' },
        t(v[2] .. comma),
    })
end

local acc = {}
for _, v in ipairs { { '{', '}' }, { '(', ')' }, { '[', ']' } } do
    table.insert(acc, newline(v, 'n', ''))
    table.insert(acc, newline(v, ',', ','))
    table.insert(acc, s(snipopts(v[1] .. ' '), { t(v[1] .. ' '), i(1), t(' ' .. v[2]) }))
    table.insert(acc, s(snipopts(v[1]), { t(v[1]), i(1), t(v[2]) }))
end
for _, v in ipairs { { '"', '"' }, { "'", "'" } } do
    table.insert(acc, s(snipopts(v[1]), { t(v[1]), i(1), t(v[2]) }))
end

ls.snippets = { all = acc }

ls.filetype_extend('bash', { 'sh' })
ls.filetype_extend('zsh', { 'sh' })
ls.filetype_extend('cpp', { 'c' })
