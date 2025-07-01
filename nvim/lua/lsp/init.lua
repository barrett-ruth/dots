local M = {}

function M.on_attach(client, bufnr)
    if client:supports_method('hover') then
        bmap({ 'n', 'K', vim.lsp.buf.hover })
    end

    if client:supports_method('documentSymbol') then
        require('nvim-navic').attach(client, bufnr)
        vim.opt_local.winbar = [[%{%v:lua.require('lines.winbar').winbar()%}]]
    end

    if client:supports_method('signatureHelp') then
        bmap({
            'n',
            'gra',
            function()
                vim.lsp.buf.signature_help()
            end,
        })
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
end

local function prepare_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = false

    local ok, blink = pcall(require, 'blink.cmp')

    return ok and blink.get_lsp_capabilities(capabilities) or capabilities
end

function M.lsp_format(opts)
    local format_opts = vim.tbl_extend('force', opts or {}, {
        filter = function(c)
            if c.name == 'typescript-tools' then
                vim.cmd.TSToolsOrganizeImports()
            end
            -- disable all lsp formatting
            return c.name == 'null-ls'
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

    require('utils').au('LspAttach', 'LspFormat', {
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
                    M.lsp_format,
                }, { buffer = opts.buf, silent = false })
            end
        end,
    })
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
            formatting.clang_format,
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
        on_attach = on_attach,
        debounce = 0,
    })
end

return M
