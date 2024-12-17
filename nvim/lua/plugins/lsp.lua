local lsp_utils = require('lsp.utils')

return {
    {
        'saghen/blink.cmp',
        lazy = false,
        build = 'cargo build --release',
        dependencies = { 'folke/lazydev.nvim', ft = 'lua' },
        opts = {
            enabled = function()
                return vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false
            end,
            keymap = {
                ['<c-p>'] = { 'select_prev' },
                ['<c-n>'] = { 'show', 'select_next' },
                ['<c-space>'] = {},
                ['<c-y>'] = {
                    function(cmp)
                        return cmp.snippet_active() and cmp.accept()
                            or cmp.select_and_accept()
                    end,
                    'snippet_forward',
                },
            },
            completion = {
                menu = {
                    auto_show = false,
                    draw = { columns = { { 'label', 'label_description' } } },
                },
                documentation = {
                    auto_show = true,
                    window = { border = 'single' },
                },
            },
            sources = {
                default = {
                    'lazydev',
                    'lsp',
                    'path',
                    'snippets',
                    'buffer',
                },
                cmdline = {},
                providers = {
                    lazydev = {
                        name = 'LazyDev',
                        module = 'lazydev.integrations.blink',
                        score_offset = 100,
                    },
                },
            },
        },
        opts_extend = { 'sources.default' },
    },
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
                local ok, settings =
                    pcall(require, ('lsp.servers.%s'):format(server))
                lspconfig[server].setup(
                    lsp_utils.prepare_lsp_settings(ok and settings or {})
                )
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
