local prepare_lsp_settings = require('lsp.utils').prepare_lsp_settings

return {
    { 'folke/neodev.nvim', ft = { 'lua' } },
    {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            require('lsp.null-ls')
        end,
        event = 'VeryLazy'
    },
    {
        'pmizio/typescript-tools.nvim',
        config = function()
            require('typescript-tools').setup(
                prepare_lsp_settings(require('lsp.servers.typescript'))
            )
        end,
        ft = { 'typescript', 'typescriptreact' },
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            require('lsp.signs')

            local lspconfig = require('lspconfig')

            for _, server in ipairs({
                'clangd',
                'cssmodules_ls',
                'cssls',
                'emmet_ls',
                'html',
                'jedi_language_server',
                'jsonls',
                'pyright',
                'lua_ls',
                'tailwindcss',
            }) do
                local status, settings =
                    pcall(require, 'lsp.servers.' .. server)

                if not status then
                    settings = {}
                end

                lspconfig[server].setup(prepare_lsp_settings(settings))
            end
        end,
        dependencies = {
            {
                'SmiteshP/nvim-navic',
                config = function(_, opts)
                    require('nvim-navic').setup(opts)
                end,
                opts = {
                    depth_limit = 2,
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
}
