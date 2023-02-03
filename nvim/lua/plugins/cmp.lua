return {
    {
        'hrsh7th/nvim-cmp',
        config = function()
            vim.g.completion_matching_strategy_list = 'exact,substring,fuzzy'
            vim.g.completeopt = 'menuone,noinsert,noselect'

            local cmp = require 'cmp'
            local mapping = cmp.mapping

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
                        vim_item.abbr = vim_item.abbr
                            :gsub('•', '')
                            :gsub('~', '')
                            :gsub('^ ', '')

                        return vim_item
                    end,
                },
                sources = cmp.config.sources {
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                },
                mapping = {
                    ['<c-y>'] = mapping.confirm(),
                    ['<c-b>'] = mapping.scroll_docs(-4),
                    ['<c-f>'] = mapping.scroll_docs(4),
                    ['<c-e>'] = function()
                        cmp.complete()
                        cmp.select_next_item()
                        cmp.confirm()
                    end,
                    ['<c-n>'] = function(_)
                        if not cmp.visible() then
                            cmp.complete()
                            cmp.select_next_item()
                        else
                            cmp.select_next_item()
                        end
                    end,
                    ['<c-p>'] = mapping.select_prev_item(),
                    ['<c-x>'] = mapping.abort(),
                },
            }

            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources {
                    { name = 'git' },
                    { name = 'conventionalcommits' },
                },
            })
        end,
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
        },
        event = 'InsertEnter',
    },
    {
        'davidsierradz/cmp-conventionalcommits',
        ft = 'gitcommit',
    },
    {
        'petertriho/cmp-git',
        ft = 'gitcommit',
        opts = {
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
        },
    },
}
