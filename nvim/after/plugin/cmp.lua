vim.g.completion_matching_strategy_list = 'exact,substring,fuzzy'
vim.g.completeopt = 'menuone,noinsert,noselect'

local cmp = require 'cmp'
local mapping = cmp.mapping

cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        completion = {
            border = 'single',
            scrollbar = false,
            winhighlight = 'Normal:None,FloatBorder:None,CursorLine:Visual',
        },
        documentation = {
            border = 'single',
        },
    },
    formatting = {
        format = function(_, vim_item)
            vim_item.kind = ''

            if vim_item.abbr:sub(-1, -1) == '~' then
                vim_item.abbr = vim_item.abbr:sub(0, -2)
            end

            vim_item.abbr = vim_item.abbr:gsub('•', '')

            return vim_item
        end,
    },
    sources = cmp.config.sources {
        { name = 'nvim_lsp' },
        { name = 'path' },
    },
    mapping = mapping {
        ['<c-y>'] = mapping.confirm(),
        ['<c-b>'] = mapping.scroll_docs(-4),
        ['<c-f>'] = mapping.scroll_docs(4),
        ['<c-e>'] = mapping.abort(),
        ['<c-n>'] = mapping.select_next_item(),
        ['<c-p>'] = mapping.select_prev_item(),
    },
}

cmp.setup.filetype({ 'mysql', 'plsql', 'sql' }, {
    sources = cmp.config.sources {
        { name = 'vim-dadbod-completion' },
    },
})

cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources {
        { name = 'git' },
        { name = 'conventionalcommits' },
    },
})

require('cmp_git').setup {
    github = {
        issues = {
            state = 'all',
        },
    },
}

local cmp_enabled = false

map {
    'i',
    '<c-space>',
    function()
        if cmp_enabled then
            require('cmp').setup.buffer { enabled = false }
            cmp.abort()
        else
            require('cmp').setup.buffer { enabled = true }
            cmp.complete()
        end

        cmp_enabled = not cmp_enabled
    end,
}
