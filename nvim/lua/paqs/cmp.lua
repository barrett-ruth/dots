local cmp = require 'cmp'

vim.api.nvim_set_var(
    'completion_matching_strategy_list',
    'exact,substring,fuzzy'
)
vim.api.nvim_set_var('completeopt', 'menuone,noinsert,noselect')

cmp.setup {
    enabled = false,
    snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end,
    },
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
            if vim_item.abbr:sub(-1, -1) == '~' then
                vim_item.abbr = vim_item.abbr:sub(0, -2)
            end

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
        ['<c-n>'] = cmp.mapping.select_next_item(),
        ['<c-p>'] = cmp.mapping.select_prev_item(),
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
