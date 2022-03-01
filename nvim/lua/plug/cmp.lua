vim.g.completion_matching_strategy_list = 'exact,substring,fuzzy'

local luasnip = require 'luasnip'
local cmp = require 'cmp'

local kinds = {
    Buffer = 'buf',
    Class = 'class',
    Constant = 'const',
    Function = 'func',
    Keyword = 'key',
    Module = 'mod',
    Property = 'prop',
    Reference = 'ref',
    Snippet = 'snip',
    Text = 'txt',
    TypeParameter = 'type',
    Variable = 'var',
    Value = 'val',
}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    formatting = {
        format = function(_, item)
            if kinds[item.kind] ~= nil then
                item.kind = kinds[item.kind]
            else
                item.kind = string.lower(item.kind)
            end

            item.kind = '[' .. item.kind .. ']'

            return item
        end,
    },
    sources = cmp.config.sources {
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
    },
    mapping = {
        ['<c-h>'] = cmp.mapping(cmp.mapping.scroll_docs(-3), { 'i', 'c' }),
        ['<c-l>'] = cmp.mapping(cmp.mapping.scroll_docs(3), { 'i', 'c' }),
        ['<cr>'] = cmp.config.disable,
        ['<c-s>'] = cmp.mapping(function(fallback)
            if luasnip.expandable() then
                luasnip.expand()
            else
                fallback()
            end
        end, { 'i' }),
        ['<c-j>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable() then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { 'i' }),
    },
}

local utils = require 'utils'
local map = utils.map
local mapstr = utils.mapstr

map { 'i', '<c-space>', mapstr('utils', 'toggle_cmp()') }
map { 'n', '<c-space>', mapstr('utils', 'toggle_cmp()') }
