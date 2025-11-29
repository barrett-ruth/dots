return {
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                { path = '${3rd}/luv/library' },
            },
        },
    },
    {
        'saghen/blink.cmp',
        build = 'cargo build --release',
        dependencies = 'folke/lazydev.nvim',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        event = { 'InsertEnter', 'CmdlineEnter' },
        opts = {
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
                    scrollbar = false,
                    max_height = vim.o.pumheight,
                    draw = {
                        columns = {
                            { 'label', 'label_description' },
                            { 'kind' },
                        },
                    },
                },
            },
            cmdline = {
                completion = {
                    menu = {
                        auto_show = true,
                    },
                },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lazydev = {
                        name = 'LazyDev',
                        module = 'lazydev.integrations.blink',
                        score_offset = 100,
                    },
                },
            },
        },
        keys = { { '<c-n>', mode = 'i' } },
        opts_extend = { 'sources.default' },
    },
    {
        'nvimtools/none-ls.nvim',
        config = function()
            require('lsp').setup_none_ls()
        end,
        dependencies = 'nvimtools/none-ls-extras.nvim',
    },
    {
        'neovim/nvim-lspconfig',
        config = function(_)
            local configs = require('lspconfig.configs')
            local nvim_lsp = require('lspconfig')

            if not configs.pytest_language_server then
                configs.pytest_language_server = {
                    default_config = {
                        cmd = { 'pytest-language-server' },
                        filetypes = { 'python' },
                        root_dir = nvim_lsp.util.root_pattern(
                            '.git',
                            'pyproject.toml',
                            'setup.py'
                        ),
                        settings = {},
                    },
                }
            end
            nvim_lsp.pytest_language_server.setup({})
        end,
        dependencies = {
            'b0o/SchemaStore.nvim',
            {
                'saecki/live-rename.nvim',
                config = function(_, opts)
                    require('live-rename').setup(opts)
                    local live_rename = require('live-rename')
                    vim.api.nvim_create_autocmd('LspAttach', {
                        callback = function(o)
                            local clients =
                                vim.lsp.get_clients({ buffer = o.buf })
                            for _, client in ipairs(clients) do
                                if
                                    client:supports_method(
                                        'textDocument/rename'
                                    )
                                then
                                    bmap(
                                        { 'n', 'grn', live_rename.rename },
                                        { buffer = o.buf }
                                    )
                                end
                            end
                        end,
                        group = vim.api.nvim_create_augroup(
                            'LiveRenameMap',
                            { clear = true }
                        ),
                    })
                end,
                keys = { 'grn' },
            },
        },
    },
    {
        'yioneko/nvim-vtsls',
        config = function(_, opts)
            require('vtsls').config(opts)
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
        },
        ft = {
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
        },
        opts = {
            on_attach = function(_, bufnr)
                bmap(
                    { 'n', 'gD', vim.cmd.VtsExec('goto_source_definition') },
                    { buffer = bufnr }
                )
            end,
            settings = {
                typescript = {
                    inlayHints = {
                        parameterNames = { enabled = 'literals' },
                        parameterTypes = { enabled = true },
                        variableTypes = { enabled = true },
                        propertyDeclarationTypes = { enabled = true },
                        functionLikeReturnTypes = { enabled = true },
                        enumMemberValues = { enabled = true },
                    },
                },
            },
            handlers = {
                ['textDocument/publishDiagnostics'] = function(_, result, ctx)
                    if not result.diagnostics then
                        return
                    end

                    local idx = 1
                    while idx <= #result.diagnostics do
                        local entry = result.diagnostics[idx]

                        local formatter =
                            require('format-ts-errors')[entry.code]
                        entry.message = formatter and formatter(entry.message)
                            or entry.message

                        if vim.tbl_contains({ 80001, 80006 }, entry.code) then
                            table.remove(result.diagnostics, idx)
                        else
                            idx = idx + 1
                        end
                    end

                    vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx)
                end,
            },
        },
    },
    {
        'pmizio/typescript-tools.nvim',
        config = function()
            require('typescript-tools').setup({
                on_attach = function(_, bufnr)
                    bmap(
                        { 'n', 'gD', vim.cmd.TSToolsGoToSourceDefinition },
                        { buffer = bufnr }
                    )
                end,
                handlers = {
                    ['textDocument/publishDiagnostics'] = function(
                        _,
                        result,
                        ctx
                    )
                        if not result.diagnostics then
                            return
                        end

                        local idx = 1
                        while idx <= #result.diagnostics do
                            local entry = result.diagnostics[idx]

                            local formatter =
                                require('format-ts-errors')[entry.code]
                            entry.message = formatter
                                    and formatter(entry.message)
                                or entry.message

                            if
                                vim.tbl_contains({ 80001, 80006 }, entry.code)
                            then
                                table.remove(result.diagnostics, idx)
                            else
                                idx = idx + 1
                            end
                        end

                        vim.lsp.diagnostic.on_publish_diagnostics(
                            _,
                            result,
                            ctx
                        )
                    end,
                },

                settings = {
                    expose_as_code_action = 'all',
                    -- tsserver_path = vim.env.XDG_DATA_HOME .. '/pnpm/tsserver',
                    tsserver_file_preferences = {
                        includeInlayParameterNameHints = 'all',
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    },
                },
            })
        end,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'neovim/nvim-lspconfig',
        },
        ft = {
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
        },
    },
    {
        'mrcjkb/rustaceanvim',
        ft = { 'rust' },
    },
    {
        'SmiteshP/nvim-navic',
        opts = {
            depth_limit = 3,
            depth_limit_indicator = '…',
            icons = {
                File = '',
                Module = '',
                Namespace = '',
                Package = '',
                Class = '',
                Method = '',
                Property = '',
                Field = '',
                Constructor = '',
                Enum = '',
                Interface = '',
                Function = '',
                Variable = '',
                Constant = '',
                String = '',
                Number = '',
                Boolean = '',
                Array = '',
                Object = '',
                Key = '',
                Null = '',
                EnumMember = '',
                Struct = '',
                Event = '',
                Operator = '',
                TypeParameter = '',
            },
        },
        dependencies = { 'neovim/nvim-lspconfig' },
        event = 'LspAttach',
    },
}
