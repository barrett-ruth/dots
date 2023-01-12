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
    Module = 'mod',
    Property = 'prop',
    Value = 'val',
    Variable = 'var',
}

cmp.setup {
    completion = { autocomplete = false },
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

            vim_item.abbr = vim_item.abbr:gsub('•', ''):gsub('~', '')

            return vim_item
        end,
    },
    sources = cmp.config.sources {
        {
            name = 'nvim_lsp',
            entry_filter = function(entry, _)
                return not vim.tbl_contains(
                    { 'Text', 'Snippet' },
                    cmp.lsp.CompletionItemKind[entry:get_kind()]
                )
            end,
        },
        { name = 'path' },
    },
    mapping = {
        ['<c-y>'] = mapping.confirm(),
        ['<c-b>'] = mapping.scroll_docs(-4),
        ['<c-f>'] = mapping.scroll_docs(4),
        ['<c-e>'] = mapping.abort(),
        ['<c-n>'] = function(_)
            if not cmp.visible() then
                cmp.complete()
            else
                cmp.select_next_item()
            end
        end,
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
