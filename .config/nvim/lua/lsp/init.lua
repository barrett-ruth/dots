local M = {}

local Methods = vim.lsp.protocol.Methods

function M.on_attach(client, bufnr)
    if client:supports_method(Methods.textDocument_hover) then
        bmap({ 'n', 'K', vim.lsp.buf.hover })
    end

    if client:supports_method(Methods.textDocument_documentSymbol) then
        local ok, navic = pcall(require, 'nvim-navic')
        if ok then
            navic.attach(client, bufnr)
        end
        vim.opt_local.winbar = [[%{%v:lua.require('lines.winbar').winbar()%}]]
    end

    local ok, _ = pcall(require, 'fzf-lua')
    if not ok then
        return
    end

    local mappings = {
        {
            Methods.textDocument_codeAction,
            'gra',
            '<cmd>FzfLua lsp_code_actions<CR>',
        },
        {
            Methods.textDocument_declaration,
            'gD',
            '<cmd>FzfLua lsp_declarations<CR>',
        },
        {
            Methods.textDocument_definition,
            'gd',
            '<cmd>FzfLua lsp_definitions<CR>',
        },
        {
            Methods.textDocument_implementation,
            'gri',
            '<cmd>FzfLua lsp_implementations<CR>',
        },
        {
            Methods.textDocument_references,
            'grr',
            '<cmd>FzfLua lsp_references<CR>',
        },
        {
            Methods.textDocument_typeDefinition,
            'grt',
            '<cmd>FzfLua lsp_typedefs<CR>',
        },
        {
            Methods.textDocument_documentSymbol,
            'gs',
            '<cmd>FzfLua lsp_document_symbols<CR>',
        },
        {
            Methods.workspace_diagnostic,
            'gw',
            '<cmd>FzfLua lsp_workspace_diagnostics<CR>',
        },
        {
            Methods.workspace_symbol,
            'gS',
            '<cmd>FzfLua lsp_workspace_symbols<CR>',
        },
    }

    for _, m in ipairs(mappings) do
        local method, key, cmd = unpack(m)
        if client:supports_method(method) then
            bmap({ 'n', key, cmd })
        end
    end
end

local function prepare_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = false

    local ok, blink = pcall(require, 'blink.cmp')

    return ok and blink.get_lsp_capabilities(capabilities) or capabilities
end

local FORMAT_LSPS = { 'null-ls', 'clangd', 'tinymist', 'ruff' }

function M.lsp_format(opts)
    local format_opts = vim.tbl_extend('force', opts or {}, {
        filter = function(c)
            if c.name == 'typescript-tools' then
                vim.cmd.TSToolsOrganizeImports()
            end
            return vim.tbl_contains(FORMAT_LSPS, c.name)
        end,
    })
    vim.lsp.buf.format(format_opts)
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
    })

    vim.lsp.config('*', {
        on_attach = M.on_attach,
        capabilities = prepare_capabilities(),
        flags = { debounce_text_changes = 0 },
    })

    vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(opts)
            local client = vim.lsp.get_client_by_id(opts.data.client_id)

            if
                client
                and (
                    client:supports_method('textDocument/formatting')
                    or client:supports_method('formatting')
                )
            then
                local modes = { 'n' }

                if
                    client:supports_method('textDocument/fomatting')
                    or client:supports_method('rangeFormatting')
                then
                    table.insert(modes, 'x')
                end

                bmap({
                    modes,
                    'gF',
                    M.lsp_format,
                }, { buffer = opts.buf, silent = false })
            end
        end,
        group = vim.api.nvim_create_augroup('LspFormat', { clear = true }),
    })

    for _, server in ipairs({
        'bashls',
        'basedpyright',
        'clangd',
        'cssls',
        'emmet_language_server',
        'eslint',
        'html',
        'mdx_analyzer',
        'jsonls',
        'vtsls',
        'pytest_lsp',
        'lua_ls',
        'ruff',
        'tinymist',
    }) do
        local ok, config = pcall(require, 'lsp.' .. server)
        if ok and config then
            vim.lsp.config(server, config)
        end
        vim.lsp.enable(server)
    end
end

function M.setup_none_ls()
    local null_ls = require('null-ls')
    local builtins = null_ls.builtins
    local code_actions, diagnostics, formatting, hover =
        builtins.code_actions,
        builtins.diagnostics,
        builtins.formatting,
        builtins.hover

    null_ls.setup({
        border = 'single',
        sources = {
            require('none-ls.code_actions.eslint_d'),
            code_actions.gitrebase,

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
                    return vim.fn.executable('mypy') == 1
                        and require('null-ls.utils').path.exists(params.bufname)
                end,
            }),
            diagnostics.selene,
            diagnostics.zsh,

            formatting.black,
            formatting.isort.with({
                extra_args = { '--profile', 'black' },
            }),
            formatting.buf,
            formatting.cbfmt,
            formatting.cmake_format,
            require('none-ls.formatting.latexindent'),
            formatting.prettierd.with({
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
            }),
            formatting.stylua.with({
                condition = function(utils)
                    return utils.root_has_file({ 'stylua.toml', '.stylua.toml' })
                end,
            }),

            hover.dictionary,
            hover.printenv,
        },
        on_attach = M.on_attach,
        debounce = 0,
    })
end

return M
