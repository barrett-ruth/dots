local M = {}

local function on_attach(client, bufnr)
    local mappings = {
        hover = { 'n', 'K', vim.lsp.buf.hover },
    }

    for provider, mapping in pairs(mappings) do
        if client.server_capabilities[('%sProvider'):format(provider)] then
            bmap(mapping)
        end
    end

    if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
    end

    bmap({ 'n', '\\f', vim.diagnostic.open_float })
    bmap({
        'n',
        '\\t',
        function()
            local level = vim.lsp.log.get_level()
            vim.lsp.log.set_level(
                vim.lsp.log_levels[level] == 'WARN' and 'OFF' or 'WARN'
            )
        end,
    })
    bmap({
        'n',
        ']\\',
        function()
            vim.diagnostic.jump({ count = 1 })
        end,
    })
    bmap({
        'n',
        '[\\',
        function()
            vim.diagnostic.jump({ count = -1 })
        end,
    })
end

local function prepare_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = false

    local ok, blink = pcall(require, 'blink.cmp')

    return ok and blink.get_lsp_capabilities(capabilities) or capabilities
end

local function lsp_format()
    vim.lsp.buf.format({
        filter = function(c)
            if c.name == 'tsserver' then
                vim.cmd.TSToolsOrganizeImports()
            end
            -- disable all lsp formatting
            return c.name == 'null-ls'
        end,
    })
    vim.cmd.w()
end

function M.setup()
    vim.diagnostic.config({
        signs = false,
        float = {
            format = function(diagnostic)
                return ('%s (%s)'):format(diagnostic.message, diagnostic.source)
            end,
            header = '',
            prefix = ' ',
        },
        jump = { float = true },
        virtual_text = {
            virtual_lines = { current_line = true },
            format = function(diagnostic)
                return vim.split(diagnostic.message, '\n')[1]
            end,
        },
    })

    local lspconfig = require('lspconfig')
    lspconfig.util.default_config =
        vim.tbl_extend('force', lspconfig.util.default_config, {
            on_attach = on_attach,
            capabilities = prepare_capabilities(),
            flags = { debounce_text_changes = 0 },
        })

    vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(opts)
            local client = vim.lsp.get_client_by_id(opts.data.client_id)

            if client and client:supports_method('textDocument/formatting') then
                local modes = { 'n' }

                if client:supports_method('textDocument/rangeFormatting') then
                    table.insert(modes, 'x')
                end

                bmap({
                    modes,
                    'gF',
                    lsp_format,
                }, { buffer = opts.buf, silent = false })
            end
        end,
        group = vim.api.nvim_create_augroup('LSPFormat', { clear = true }),
    })
end

function M.setup_none_ls()
    local null_ls, logger = require('null-ls'), require('null-ls.logger')
    local builtins = null_ls.builtins
    local code_actions, diagnostics, formatting, hover =
        builtins.code_actions,
        builtins.diagnostics,
        builtins.formatting,
        builtins.hover

    local function check_formatter_exit_code(code, stderr)
        local success = code <= 0

        if not success then
            vim.schedule(function()
                logger:warn(('failed to run formatter: %s'):format(stderr))
            end)
        end

        return success
    end

    null_ls.setup({
        border = 'single',
        sources = {
            require('none-ls.code_actions.eslint_d'),
            code_actions.gitrebase,
            code_actions.gitsigns,

            diagnostics.buf,
            diagnostics.checkmake,
            require('none-ls.diagnostics.cpplint').with({
                extra_args = {
                    '--filter',
                    '-legal/copyright',
                    '-whitespace/indent',
                },
                prepend_extra_args = true,
            }),
            require('none-ls.diagnostics.eslint_d'),
            diagnostics.hadolint,
            diagnostics.mypy.with({
                extra_args = { '--check-untyped-defs' },
                runtime_condition = function(params)
                    return require('null-ls.utils').path.exists(params.bufname)
                end,
            }),
            diagnostics.selene,
            diagnostics.zsh,

            formatting.black,
            formatting.isort.with({
                extra_args = { '--profile', 'black' }
            }),
            formatting.buf.with({
                check_exit_code = check_formatter_exit_code,
            }),
            formatting.cbfmt.with({
                check_exit_code = check_formatter_exit_code,
            }),
            formatting.cmake_format.with({
                check_exit_code = check_formatter_exit_code,
            }),
            require('none-ls.formatting.eslint_d').with({

                check_exit_code = check_formatter_exit_code,
            }),
            formatting.prettierd.with({
                check_exit_code = check_formatter_exit_code,
                env = {
                    XDG_RUNTIME_DIR = vim.env.XDG_RUNTIME_DIR
                        or (vim.env.XDG_DATA_HOME .. '/prettierd'),
                },
                filetypes = {
                    'css',
                    'graphql',
                    'html',
                    'javascript',
                    'javascriptreact',
                    'json',
                    'jsonc',
                    'markdown',
                    'mdx',
                    'typescript',
                    'typescriptreact',
                    'yaml',
                },
            }),
            formatting.shfmt.with({
                extra_args = { '-i', '2' },
                check_exit_code = check_formatter_exit_code,
            }),
            formatting.stylua.with({
                condition = function(utils)
                    return utils.root_has_file({ 'stylua.toml', '.stylua.toml' })
                end,
                -- check_exit_code = check_formatter_exit_code,
            }),

            hover.dictionary,
            hover.printenv,
        },
        on_attach = on_attach,
        debounce = 0,
    })
end

return M
