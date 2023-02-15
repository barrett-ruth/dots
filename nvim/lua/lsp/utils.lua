local M = {}

local api = vim.api

local function format()
    vim.lsp.buf.format {
        filter = function(client)
            return not vim.tbl_contains({
                'clangd', -- clang-format
                'cssls', -- prettier
                'html', -- prettier
                'jedi_language_server', -- black/autopep8
                'jsonls', -- prettier
                'pyright', -- black/autopep8
                'sqls', -- sql-formatter
                'lua_ls', -- stylua
                'tsserver', -- prettier
            }, client.name)
        end,
    }
end

function M.on_attach(client, bufnr)
    if pcall(require, 'ufo') then
        vim.api.nvim_win_set_option(vim.fn.bufwinid(bufnr), 'foldcolumn', '1')
    end

    local ok, navic = pcall(require, 'nvim-navic')
    local server_capabilities = client.server_capabilities

    if ok and server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
        vim.opt_local.winbar = [[%{%v:lua.require('lines.winbar').winbar()%}]]
    end

    local diagnostic, buf = vim.diagnostic, vim.lsp.buf

    if server_capabilities.documentFormattingProvider then
        api.nvim_create_autocmd('BufWritePre', {
            pattern = '<buffer>',
            callback = format,
            group = api.nvim_create_augroup('AFormat', { clear = false }),
        })
    end

    if server_capabilities.codeActionProvider then
        bmap { 'n', '\\c', buf.code_action }
    end

    local builtin = require 'telescope.builtin'

    bmap { 'n', '\\d', builtin.diagnostics }
    bmap { 'n', '\\f', diagnostic.open_float }
    if server_capabilities.renameProvider then
        map { 'n', '\\r', ':IncRename ' }
    end

    if server_capabilities.hoverProvider then
        bmap { 'n', 'K', buf.hover }
    end

    if server_capabilities.definitionProvider then
        bmap { 'n', 'gd', builtin.lsp_definitions }
    end
    if server_capabilities.declarationProvider then
        bmap { 'n', 'gD', buf.declaration }
    end
    if server_capabilities.implementationProvider then
        bmap { 'n', 'gi', builtin.lsp_implementations }
    end
    if server_capabilities.referencesProvider then
        bmap { 'n', 'gr', builtin.lsp_references }
    end
    if server_capabilities.typeDefinitionProvider then
        bmap { 'n', 'gt', builtin.lsp_type_definitions }
    end

    bmap {
        'n',
        ']\\',
        function()
            diagnostic.goto_next { wrap = true }
        end,
    }
    bmap {
        'n',
        '[\\',
        function()
            diagnostic.goto_prev { wrap = true }
        end,
    }

    if server_capabilities.documentSymbolProvider then
        bmap {
            'n',
            '\\sa',
            function()
                builtin.lsp_document_symbols {
                    ignore_symbols = {
                        'array',
                        'constant',
                        'enummember',
                        'field',
                        'string',
                        'variable',
                    },
                }
            end,
        }
        bmap {
            'n',
            '\\sc',
            function()
                builtin.lsp_document_symbols { symbols = 'Class' }
            end,
        }
        bmap {
            'n',
            '\\sf',
            function()
                builtin.lsp_document_symbols { symbols = 'Function' }
            end,
        }
    end

    if server_capabilities.signatureHelpProvider then
        bmap { 'i', '<c-space>', buf.signature_help }
    end
end

function M.prepare_lsp_settings(user_settings)
    local settings = {}

    settings.capabilities = require('cmp_nvim_lsp').default_capabilities()
    settings.capabilities.offsetEncoding = { 'utf-16' }
    settings.capabilities.textDocument.completion.completionItem.snippetSupport =
        false
    settings.capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }

    settings.flags = { debounce_text_changes = 0 }

    settings = vim.tbl_extend('force', settings, user_settings)

    settings.on_attach = function(...)
        if user_settings.on_attach then
            user_settings.on_attach(...)
        end

        M.on_attach(...)
    end

    return settings
end

return M
