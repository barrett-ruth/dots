vim.g.completion_matching_strategy_list = 'exact,substring,fuzzy'
vim.g.completeopt = 'menuone,noinsert,noselect'

local cmp = require 'cmp'
local mapping = cmp.mapping

local kinds = {
    Class = 'cls',
    Constant = 'const',
    Enum = 'enum',
    Field = 'field',
    Function = 'fn',
    Keyword = 'key',
    Method = 'meth',
    Property = 'prop',
    Variable = 'var',
}

cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        completion = {
            border = 'rounded',
            scrollbar = false,
            winhighlight = 'Normal:None,FloatBorder:None,CursorLine:Visual',
        },
        documentation = {
            border = 'rounded',
        },
    },
    formatting = {
        format = function(_, vim_item)
            vim_item.kind = kinds[vim_item.kind] or vim_item.kind

            if vim_item.abbr:sub(-1, -1) == '~' then
                vim_item.abbr = vim_item.abbr:sub(0, -2)
            end

            vim_item.abbr = vim_item.abbr:gsub('•', '')

            return vim_item
        end,
    },
    sources = cmp.config.sources {
        {
            name = 'nvim_lsp',
            entry_filter = function(entry, _)

                return cmp.lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
                    and cmp.lsp.CompletionItemKind[entry:get_kind()] ~= 'Snippet'
            end,
        },
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
    gitlab = {
        issues = {
            state = 'all',
        },
    },
}
