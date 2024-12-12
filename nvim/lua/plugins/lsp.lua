local lsp_utils = require('lsp.utils')

return {
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
                'cssls',
                'cssmodules_ls',
                'emmet_language_server',
                'eslint',
                'html',
                'jsonls',
                'lua_ls',
                'pylsp',
            }) do
                if vim.fn.executable(server) == 1 then
                    local ok, settings =
                        pcall(require, ('lsp.servers.%s'):format(server))
                    lspconfig[server].setup(
                        lsp_utils.prepare_lsp_settings(ok and settings or {})
                    )
                end
            end
        end,
        dependencies = { 'b0o/SchemaStore.nvim' },
    },
    {
        'pmizio/typescript-tools.nvim',
        opts = function()
            return lsp_utils.prepare_lsp_settings(
                require('lsp.servers.typescript')
            )
        end,
        dependencies = {
            {
                'davidosomething/format-ts-errors.nvim',
                ft = {
                    'javascript',
                    'javascriptreact',
                    'typescript',
                    'typescriptreact',
                },
            },
            'nvim-lua/plenary.nvim',
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
        },
        event = {
            'BufReadPre *.js,*.jsx,*.ts,*.tsx',
            'BufNewFile *.js,*.jsx,*.ts,*.tsx',
        },
    },
    {
        'mrcjkb/rustaceanvim',
        ft = { 'rust' },
        config = function()
            vim.g.rustaceanvim = {
                server = lsp_utils.prepare_lsp_settings(
                    require('lsp.servers.rust_analyzer')
                ),
            }
        end,
    },
    {
        'saecki/live-rename.nvim',
        event = 'LspAttach',
        opts = {
            hl = {
                current = 'Visual',
                others = 'Visual',
            },
        },
        keys = {
            {
                'grn',
                '<cmd>lua require("live-rename").rename()<cr>',
            },
        },
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
        dependencies = { 'neovim/nvim-lspconfig' },
        event = 'LspAttach',
    },
}
