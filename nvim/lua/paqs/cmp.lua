local cmp = require 'cmp'

vim.api.nvim_set_var('completion_matching_strategy_list', 'exact,substring,fuzzy')

cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    enabled = function()
        return (CMP_ENABLED == nil) and false or CMP_ENABLED
    end,
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
    mapping = cmp.mapping {
        ['<c-b>'] = cmp.mapping.scroll_docs(-4),
        ['<c-f>'] = cmp.mapping.scroll_docs(4),
        ['<c-e>'] = cmp.mapping.abort(),
        ['<c-n>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item()
            else
                cmp.complete()
            end
        end),
        ['<c-p>'] = cmp.mapping.select_prev_item(),
        ['<c-y>'] = cmp.mapping.confirm { select = true },
    },
}

local utils = require 'utils'
utils.map {
    { 'i', 'n' },
    '<c-space>',
    function()
        CMP_ENABLED = not CMP_ENABLED
        if CMP_ENABLED then
            cmp.complete()
        else
            cmp.close()
        end
    end,
}
