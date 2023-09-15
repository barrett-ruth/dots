local prepare_lsp_settings = require('lsp.utils').prepare_lsp_settings

return {
    { 'folke/neodev.nvim', ft = { 'lua' } },
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
            require('lsp.signs')

            local lspconfig = require('lspconfig')

            for _, server in ipairs({
                'clangd',
                'cssmodules_ls',
                'cssls',
                'emmet_ls',
                'eslint',
                'gopls',
                'html',
                'jsonls',
                'ltex',
                'lua_ls',
                'pyright',
                'pylsp',
                'tailwindcss',
                'tsserver',
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
}
