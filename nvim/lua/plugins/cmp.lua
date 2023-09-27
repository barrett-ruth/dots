return {
    {
        'hrsh7th/nvim-cmp',
        opts = {
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            completion = { autocomplete = false },
            window = {
                completion = {
                    border = 'single',
                    scrollbar = false,
                    winhighlight = 'CursorLine:Visual',
                },
                documentation = { border = 'single' },
            },
            formatting = {
                format = function(_, item)
                    return require('tailwindcss-colorizer-cmp').formatter(
                        _,
                        item
                    )
                end,
            },
        },
        config = function(_, opts)
            vim.g.completion_matching_strategy_list = 'exact,substring,fuzzy'
            vim.g.completeopt = 'menuone,noinsert,noselect'

            local cmp = require('cmp')
            local mapping = cmp.mapping

            opts = vim.tbl_extend('keep', opts, {
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                }, {
                    { name = 'buffer' },
                }),
                mapping = cmp.mapping.preset.insert({
                    ['<c-y>'] = mapping.confirm({ select = true }),
                    ['<c-b>'] = mapping.scroll_docs(-4),
                    ['<c-f>'] = mapping.scroll_docs(4),
                    ['<c-n>'] = function()
                        if not cmp.visible() then
                            cmp.complete()
                        end
                        cmp.select_next_item()
                    end,
                    ['<c-p>'] = mapping.select_prev_item(),
                    ['<c-x>'] = mapping.abort(),
                    ['<c-e>'] = function()
                        cmp.complete()
                        cmp.select_next_item()
                        cmp.confirm()
                    end,
                }),
            })

            cmp.setup(opts)

            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    { name = 'git' },
                    { name = 'conventionalcommits' },
                }),
            })
        end,
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'L3MON4D3/LuaSnip',
            'roobert/tailwindcss-colorizer-cmp.nvim',
        },
        event = 'InsertEnter',
    },
    {
        'davidsierradz/cmp-conventionalcommits',
        dependencies = 'hrsh7th/nvim-cmp',
        ft = { 'gitcommit' },
    },
    {
        'petertriho/cmp-git',
        dependencies = 'hrsh7th/nvim-cmp',
        ft = { 'gitcommit' },
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
