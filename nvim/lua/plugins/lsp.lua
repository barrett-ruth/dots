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
        'nvimtools/none-ls.nvim',
        config = function()
            require('lsp.none-ls')
        end,
        event = 'VeryLazy',
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            require('lsp.config')

            local lspconfig = require('lspconfig')

            for _, server in ipairs({
                'bashls',
                'clangd',
                'cssmodules_ls',
                'cssls',
                'emmet_language_server',
                'eslint',
                'gopls',
                'html',
                'jsonls',
                'lua_ls',
                'pyright',
                'ltex',
                'pylsp',
                'ruby_ls',
                'tailwindcss',
                'yamlls',
            }) do
                local status, settings =
                    pcall(require, 'lsp.servers.' .. server)

                lspconfig[server].setup(
                    prepare_lsp_settings(status and settings or {})
                )
            end
        end,
    },
    {
        'pmizio/typescript-tools.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
        event = {
            'BufReadPre *.js,*.jsx,*.ts,*.tsx',
            'BufNewFile *.js,*.jsx,*.ts,*.tsx',
        },
        opts = function()
            return prepare_lsp_settings(require('lsp.servers.typescript'))
        end,
    },
    {
        'mrcjkb/rustaceanvim',
        ft = { 'rust' },
        init = function()
            vim.g.rustaceanvim = {
                tools = {
                    inlay_hints = {
                        auto = false,
                    },
                },
                server = prepare_lsp_settings(
                    require('lsp.servers.rust_analyzer')
                ),
            }
        end,
    },
    {
        'SmiteshP/nvim-navic',
        opts = {
            depth_limit = 4,
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
        },
        dependencies = 'neovim/nvim-lspconfig',
        event = 'LspAttach',
    },
}
