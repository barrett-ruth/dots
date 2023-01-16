local prepare_lsp_settings = require('lsp.utils').prepare_lsp_settings

return {
    {
        'b0o/SchemaStore.nvim',
        ft = { 'json', 'jsonc' },
        lazy = true,
    },
    { 'folke/neodev.nvim', ft = 'lua', lazy = true },
    {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            require 'lsp.null-ls'
        end,
    },
    {
        'jose-elias-alvarez/typescript.nvim',
        config = function()
            require('typescript').setup {
                server = prepare_lsp_settings(require 'lsp.servers.typescript'),
            }
        end,
        ft = {
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
        },
        lazy = true,
    },
    'kristijanhusak/vim-dadbod-ui',
    'nanotee/sqls.nvim',
    {
        'neovim/nvim-lspconfig',
        config = function()
            require 'lsp.signs'

            local lspconfig = require 'lspconfig'

            for _, server in ipairs {
                'clangd',
                'cssmodules_ls',
                'cssls',
                'html',
                'jedi_language_server',
                'jsonls',
                'pyright',
                'sqls',
                'sumneko_lua',
                'tailwindcss',
            } do
                local status, settings =
                    pcall(require, 'lsp.servers.' .. server)

                if not status then
                    settings = {}
                end

                lspconfig[server].setup(prepare_lsp_settings(settings))
            end
        end,
    },
    {
        'tpope/vim-dadbod',
        config = function()
            vim.g.db_ui_save_location = vim.env.XDG_DATA_HOME .. '/nvim/db_ui'
            vim.g.db_ui_show_help = 0
            vim.g.db_ui_icons = {
                expanded = 'v',
                collapsed = '>',
                saved_query = '*',
                new_query = '+',
                tables = '~',
                buffers = '>>',
                connection_ok = '✓',
                connection_error = '✕',
            }
        end,
        keys = {
            { '<leader>db', ':DB ', { silent = false } },
            { '<leader>du', '<cmd>DBUIToggle<cr>' },
        },
    },
}
