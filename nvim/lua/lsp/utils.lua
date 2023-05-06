local M = {}

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
                'lua_ls', -- stylua
                'tsserver', -- prettier
            }, client.name)
        end,
    }
end

function M.on_attach(client, bufnr)
    local server_capabilities = client.server_capabilities

    if server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
    end

    local diagnostic, buf = vim.diagnostic, vim.lsp.buf

    if server_capabilities.documentFormattingProvider then
        bmap({
            'n',
            '<leader>w',
            function()
                format()
                vim.cmd.w()
            end,
        }, { buffer = bufnr, silent = false })
    end

    local fzf = require 'fzf-lua'

    bmap { 'n', '\\c', buf.code_action }
    bmap { 'n', '\\d', fzf.lsp_workspace_diagnostics }
    bmap { 'n', '\\f', diagnostic.open_float }
    bmap { 'n', 'K', buf.hover }
    bmap { 'n', 'gd', fzf.lsp_definitions }
    bmap { 'n', 'gD', buf.declaration }
    bmap { 'n', 'gI', fzf.lsp_implementations }
    bmap { 'n', 'gr', require('lsp.rename').rename }
    bmap { 'n', 'gR', fzf.lsp_references }
    bmap { 'n', 'gt', fzf.lsp_typedefs }

    bmap { 'n', ']\\', diagnostic.goto_next }
    bmap { 'n', '[\\', diagnostic.goto_prev }

    bmap {
        'n',
        '\\sa',
        function()
            fzf.lsp_document_symbols {
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
            fzf.lsp_document_symbols { symbols = { 'Class' } }
        end,
    }
    bmap {
        'n',
        '\\sf',
        function()
            fzf.lsp_document_symbols { symbols = { 'Function' } }
        end,
    }

    bmap { 'i', '<c-space>', buf.signature_help }
end

function M.prepare_lsp_settings(user_settings)
    local settings = {}

    settings.capabilities = vim.lsp.protocol.make_client_capabilities()
    settings.capabilities.offsetEncoding = { 'utf-16' }
    settings.capabilities.textDocument.completion.completionItem.snippetSupport =
        false

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
