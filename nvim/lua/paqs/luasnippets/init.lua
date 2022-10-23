local ls = require 'luasnip'
local types = require 'luasnip.util.types'

ls.config.set_config {
    region_check_events = 'InsertEnter',
    delete_check_events = 'TextChanged,TextChangedI,InsertLeave',
    update_events = 'TextChanged,TextChangedI,InsertLeave',
    history = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = {
                    { ' <- ', 'CursorLine' },
                },
            },
        },
    },
}

local utils = require 'paqs.luasnippets.utils'
local inline, inline_with_node, newline =
    utils.inline, utils.inline_with_node, utils.newline

local acc = {}

for _, v in ipairs {
    { '("', '")' },
    { "('", "')" },
    { '([', '])' },
    { '{"', '"}' },
    { "{'", "'}" },
    { '["', '"]' },
    { "['", "']" },
    { '[(', ')]' },
} do
    table.insert(acc, inline_with_node(v))
end

for _, v in pairs {
    { '"', '"' },
    { "'", "'" },
    { '<', '>' },

    { '(', ')' },
    { '{', '}' },
    { '[[', ']]' },
    { '[', ']' },

    { '( ', ' )' },
    { '{ ', ' }' },
    { '[ ', ' ]' },

    { '({ ', ' })' },
} do
    table.insert(acc, inline(v))
end

for _, v in ipairs {
    { '(', ')' },
    { '{', '}' },
    { '[[', ']]' },
    { '[', ']' },

    { '(', '),' },
    { '{', '},' },
    { '[', '],' },
} do
    table.insert(acc, newline(v))
end

ls.add_snippets(nil, { all = acc })
require('luasnip.loaders.from_lua').lazy_load {
    paths = '~/.config/nvim/lua/paqs/luasnippets',
}

require 'paqs.luasnippets.map'
