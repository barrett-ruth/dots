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

local utils = require 'paqs.luasnippets.utils'
local inline, newline = utils.inline, utils.newline

local acc = {}

for _, v in ipairs { { '({', '})' }, { '[[', ']]' } } do
    table.insert(acc, inline(v))
    table.insert(acc, inline { v[1] .. ' ', ' ' .. v[2] })
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

for _, v in ipairs { { "'", "'" }, { '"', '"' }, { '<', '>' } } do
    table.insert(acc, inline(v))
end

ls.add_snippets(nil, { all = acc })
require('luasnip.loaders.from_lua').lazy_load { paths = '~/.config/nvim/lua/paqs/luasnippets' }

require 'paqs.luasnippets.map'
