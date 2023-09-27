local prepare_lsp_settings = require('lsp.utils').prepare_lsp_settings

return {
    {
        'davidosomething/format-ts-errors.nvim',
        dependencies = 'neovim/nvim-lspconfig',
        ft = {
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
        },
    },
    { 'folke/neodev.nvim', ft = 'lua' },
    {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            require('lsp.null-ls')
        end,
        event = 'VeryLazy',
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            require('lsp.config')

            local lspconfig = require('lspconfig')

            for _, server in ipairs({
                'clangd',
                'cssmodules_ls',
                'cssls',
                'eslint',
                'gopls',
                'html',
                'jsonls',
                'ltex',
                'lua_ls',
                'pyright',
                'pylsp',
                'tailwindcss',
            }) do
                local status, settings =
                    pcall(require, 'lsp.servers.' .. server)

                lspconfig[server].setup(
                    prepare_lsp_settings(status and settings or {})
                )
            end
        end,
        dependencies = {
            {
                'SmiteshP/nvim-navic',
                config = function(_, opts)
                    require('nvim-navic').setup(opts)
                    vim.api.nvim_create_autocmd('BufEnter', {
                        callback = function()
                            if vim.api.nvim_buf_line_count(0) > 10000 then
                                vim.b.navic_lazy_update_context = true
                            end
                        end,
                        group = vim.api.nvim_create_augroup('ANavic', {}),
                    })
                end,
                opts = {
                    depth_limit = 3,
                    depth_limit_indicator = '...',
                    icons = {
                        File = ' ',
                        Module = ' ',
                        Namespace = ' ',
                        Package = ' ',
                        Class = ' ',
                        Method = ' ',
                        Property = ' ',
                        Field = ' ',
                        Constructor = ' ',
                        Enum = ' ',
                        Interface = ' ',
                        Function = ' ',
                        Variable = ' ',
                        Constant = ' ',
                        String = ' ',
                        Number = ' ',
                        Boolean = ' ',
                        Array = ' ',
                        Object = ' ',
                        Key = ' ',
                        Null = ' ',
                        EnumMember = ' ',
                        Struct = ' ',
                        Event = ' ',
                        Operator = ' ',
                        TypeParameter = ' ',
                    },
                    lsp = {
                        auto_attach = true,
                        preference = { 'pyright' },
                    },
                    separator = ' ->',
                },
            },
        },
    },
    {
        'pmizio/typescript-tools.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
        event = {
            'BufReadPre *.js,*.jsx,*.ts,*.tsx',
            'BufNewFile *.js,*.jsx,*.ts,*.tsx',
        },
        opts = function()
            return require('lsp.servers.typescript')
        end,
    },
}
