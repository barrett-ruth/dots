vim.g.completion_matching_strategy_list = 'exact,substring,fuzzy'

local cmp = require 'cmp'
local mapping = require 'cmp.config.mapping'
local luasnip = require 'luasnip'

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
            item.kind = kinds[item.kind] ~= nil and kinds[item.kind] or string.lower(item.kind)

            item.kind = '[' .. item.kind .. ']'
            return item
        end,
    },
    sources = cmp.config.sources {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
    },
    mapping = {
        ['<c-h>'] = cmp.mapping(cmp.mapping.scroll_docs(-3), { 'i' }),
        ['<c-l>'] = cmp.mapping(cmp.mapping.scroll_docs(3), { 'i' }),
        ['<c-y>'] = mapping {
            i = function()
                if cmp.visible() then
                    cmp.confirm()
                    cmp.close()
                end
            end,
        },
        ['<c-p>'] = function()
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            end
        end,
        ['<c-n>'] = function()
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            end
        end,
        ['<c-s>'] = function()
            if luasnip.expandable() then
                luasnip.expand()
            end
        end,
    },
}

local utils = require 'utils'
local map = utils.map
local mapstr = utils.mapstr

map { 'i', '<c-space>', mapstr('utils', 'toggle_cmp()') }
