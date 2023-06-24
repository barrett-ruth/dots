local prepare_lsp_settings = require('lsp.utils').prepare_lsp_settings

return {
    {
        'dmmulroy/tsc.nvim',
        ft = {
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
        },
        opts = {
            auto_open_qflist = false,
            flags = {
                build = true,
                noEmit = true,
            },
            enable_progress_notifications = false,
        },
    },
    'folke/neodev.nvim',
    {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            require('lsp.null-ls')
        end,
    },
    {
        'pmizio/typescript-tools.nvim',
        config = function()
            require('typescript-tools').setup(
                prepare_lsp_settings(require('lsp.servers.typescript'))
            )
        end,
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            require('lsp.signs')

            local lspconfig = require('lspconfig')

            for _, server in ipairs({
                'cssmodules_ls',
                'cssls',
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
    {
        'p00f/clangd_extensions.nvim',
        config = function(_, opts)
            require('clangd_extensions').setup(opts)
        end,
        opts = {
            server = prepare_lsp_settings(require('lsp.servers.clangd')),
        },
        ft = {
            'c',
            'cpp',
            'objc',
            'objcpp',
            'cuda',
            'proto',
        },
    },
}
