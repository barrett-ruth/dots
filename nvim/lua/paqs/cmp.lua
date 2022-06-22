local cmp = require 'cmp'

vim.api.nvim_set_var(
    'completion_matching_strategy_list',
    'exact,substring,fuzzy'
)
vim.api.nvim_set_var('completeopt', 'menuone,noinsert,noselect')

cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    enabled = false,
    window = {
        completion = {
            border = 'single',
            winhighlight = 'Normal:None,FloatBorder:None,CursorLine:Visual',
        },
        documentation = {
            border = 'single',
            max_width = 9999,
        },
    },
    formatting = {
        format = function(_, vim_item)
            vim_item.menu = ''
            vim_item.kind = ''

            return vim_item
        end,
    },
    sources = cmp.config.sources {
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'path' },
    },
}

local utils = require 'utils'
utils.map {
    { 'i', 'n' },
    '<c-space>',
    function()
        CMP_ENABLED = (CMP_ENABLED == nil) and true or not CMP_ENABLED
        if CMP_ENABLED then
            cmp.setup.buffer { enabled = true }
            cmp.complete()
        else
            cmp.setup.buffer { enabled = false }
            cmp.close()
        end
    end,
}

utils.map { 'i', '<c-n>', utils.mapstr('cmp', 'select_next_item()') }
utils.map { 'i', '<c-p>', utils.mapstr('cmp', 'select_prev_item()') }
utils.map { 'i', '<c-y>', utils.mapstr('cmp', 'confirm { select = true }') }
utils.map { 'i', '<c-b>', utils.mapstr('cmp', 'scroll_docs(-4)') }
utils.map { 'i', '<c-f>', utils.mapstr('cmp', 'scroll_docs(4)') }
utils.map { 'i', '<c-e>', utils.mapstr('cmp', 'abort()') }
