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

require 'paqs.cmp.map'
