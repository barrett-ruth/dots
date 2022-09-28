local ls = require 'luasnip'
local types = require 'luasnip.util.types'

ls.config.set_config {
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
local basic_inline, inline_with_node, inline_special, newline =
    utils.basic_inline,
    utils.inline_with_node,
    utils.inline_special,
    utils.newline

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

table.insert(acc, inline_special '({ ')

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
} do
    table.insert(acc, basic_inline(v))
end

for _, v in ipairs {
    { '(', ')' },
    { '{', '}' },
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
