vim.g.completion_matching_strategy_list = 'exact,substring,fuzzy'

local cmp = require 'cmp'
local mapping = require 'cmp.config.mapping'

local kinds = {
    ext = '',
    Method = '',
    Function = '',
    Constructor = '',
    Field = 'ﰠ',
    Variable = '',
    Class = 'ﴯ',
    Interface = '',
    Module = '',
    Property = 'ﰠ',
    Unit = '塞',
    Value = '',
    Enum = '',
    Keyword = '',
    Snippet = '',
    Color = '',
    File = '',
    Reference = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = 'פּ',
    Event = '',
    Operator = '',
    TypeParameter = '',
}

local sources = {
    buffer = '[BUF]',
    nvim_lsp = '[LSP]',
    nvim_lua = '[LUA]',
    path = '[PATH]',
}

cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        completion = {
            border = 'single',
        },
        documentation = {
            border = 'single',
            max_width = 9999,
        },
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = sources[entry.source.name]
            vim_item.kind = kinds[vim_item.kind]
            return vim_item
        end,
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
