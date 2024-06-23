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
        dependencies = 'nvimtools/none-ls-extras.nvim',
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
                'pylsp',
                'ruby_lsp',
                'tailwindcss',
                'vimls',
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
        dependencies = {
            'nvim-lua/plenary.nvim',
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
        },
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
        config = function()
            vim.g.rustaceanvim = {
                server = prepare_lsp_settings(
                    require('lsp.servers.rust_analyzer')
                ),
            }
        end,
    },
    {
        'SmiteshP/nvim-navic',
        opts = {
            depth_limit = 3,
            depth_limit_indicator = '…',
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
