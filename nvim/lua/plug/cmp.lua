vim.g.completion_matching_strategy_list = 'exact,substring,fuzzy'

local cmp = require 'cmp'
local mapping = require 'cmp.config.mapping'
local luasnip = require 'luasnip'

local sources = {
    buffer = '[BUF]',
    nvim_lsp = '[LSP]',
    nvim_lua = '[LUA]',
    path = '[PATH]',
}

cmp.setup {
    window = {
        completion = {
            scrollbar = false,
            border = 'single',
        },
        documentation = {
            scrollbar = false,
            border = 'single',
            max_width = 9999,
        },
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    formatting = {
        format = require('lspkind').cmp_format {
            mode = 'symbol',
            before = function(entry, vim_item)
                vim_item.menu = sources[entry.source.name]
                return vim_item
            end,
        },
    },
    sources = cmp.config.sources {
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'path' },
    },
    mapping = {
        ['<c-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-3), { 'i' }),
        ['<c-f>'] = cmp.mapping(cmp.mapping.scroll_docs(3), { 'i' }),
        ['<c-y>'] = mapping {
            i = function()
                if cmp.visible() then
                    cmp.confirm()
                    cmp.close()
                else
                    cmp.complete()
                end
            end,
        },
    },
}

local utils = require 'utils'
local map = utils.map
local mapstr = utils.mapstr

map { 'i', '<c-space>', mapstr('utils', 'toggle_cmp()') }
