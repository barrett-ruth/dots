local cmp = require 'cmp'

vim.api.nvim_set_var(
    'completion_matching_strategy_list',
    'exact,substring,fuzzy'
)

vim.api.nvim_set_var('completeopt', 'menuone,noinsert,noselect')

cmp.setup {
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

            if string.find(vim_item.abbr, ' - java.') then
                vim_item.abbr = vim_item.abbr:gsub('java%.', '', 1)
            end

            return vim_item
        end,
    },
    sources = cmp.config.sources {
        { name = 'nvim_lsp' },
        { name = 'path' },
    },
    mapping = cmp.mapping {
        ['<c-y>'] = cmp.mapping.confirm(),
        ['<c-b>'] = cmp.mapping.scroll_docs(-4),
        ['<c-f>'] = cmp.mapping.scroll_docs(4),
        ['<c-e>'] = cmp.mapping.abort(),
        ['<c-n>'] = cmp.mapping.select_next_item(),
        ['<c-p>'] = cmp.mapping.select_prev_item(),
    },
}

local utils = require 'utils'
utils.map {
    'i',
    '<c-space>',
    function()
        if CMP_ENABLED == nil or CMP_ENABLED then
            cmp.setup.buffer { enabled = false }
            cmp.close()
            CMP_ENABLED = false
        else
            cmp.setup.buffer { enabled = true }
            cmp.complete()
            CMP_ENABLED = true
        end
    end,
}
