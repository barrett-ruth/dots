local cmp = require 'cmp'

vim.g.completion_matching_strategy_list = 'exact,substring,fuzzy'
vim.g.completeopt = 'menuone,noinsert,noselect'

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
            vim_item.kind = ''

            -- Change snippets that leaked through from
            -- neodev into regular entries
            if vim_item.abbr:sub(-1, -1) == '~' then
                vim_item.abbr = vim_item.abbr:sub(0, -2)
            end

            -- Trim padding added by clangd
            if vim_item.abbr:sub(0, 1) == ' ' then
                vim_item.abbr = vim_item.abbr:sub(2)
            end

            return vim_item
        end,
    },
    sources = cmp.config.sources {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'buffer' },
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

cmp.setup.filetype({ 'sql', 'mysql', 'plsql' }, {
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
