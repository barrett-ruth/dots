local M = {}

local deny_format = { tsserver = true, clangd = true, sumneko_lua = true, jsonls = true }

M.on_attach = function(client, _)
    local utils = require 'utils'
    local bmap, mapstr = utils.bmap, utils.mapstr

    if deny_format[client.name] then
        client.resolved_capabilities.document_formatting = false
    end

    if client.name == 'tsserver' then
        local ts_utils = require 'nvim-lsp-ts-utils'

        ts_utils.setup {
            auto_inlay_hints = false,
            enable_import_on_completion = true,
            update_imports_on_move = true,
        }

        ts_utils.setup_client(client)

        bmap { 'n', '\\ti', mapstr 'TSLspImportAll' }
        bmap { 'n', '\\to', mapstr 'TSLspOrganize' }
    elseif client.name == 'clangd' then
        bmap { 'n', '\\H', mapstr 'ClangdSwitchSourceHeader' }
    end

    if client.server_capabilities.documentSymbolProvider then
        for k, v in pairs { a = '', f = 'Function', c = 'Class', m = 'Module' } do
            bmap {
                'n',
                '\\s' .. k,
                mapstr('fzf-lua', string.format([[lsp_document_symbols({ regex_filter = '%s.*' })]], v)),
            }
        end
    end

    bmap { 'n', ']\\', mapstr 'lua vim.diagnostic.goto_next()' }
    bmap { 'n', '[\\', mapstr 'lua vim.diagnostic.goto_prev()' }
    bmap { 'n', '\\f', mapstr 'lua vim.diagnostic.open_float()' }
    bmap { 'n', '\\h', mapstr 'lua vim.lsp.buf.hover()' }

    AAA = client.server_capabilities

    for k, v in pairs {
        c = { 'code_action', 'codeActions' },
        d = { 'definition', 'definitions' },
        D = { 'declaration', 'declarations' },
        i = { 'implementation', 'implementations' },
        R = { 'references', 'references' }
    } do
        if client.server_capabilities[v[1] .. 'Provider'] then
            bmap { 'n', '\\' .. k, mapstr('fzf-lua', 'lsp_' .. v[2] .. '()') }
        end
    end

    if client.server_capabilities.renameProvider then
        bmap { 'n', '\\r', '<esc>' .. mapstr('paqs.refactor', [[setup_win('rename')]]) }
    end

    bmap { 'x', '\\e', '<esc>' .. mapstr('paqs.refactor', [[setup_win('extract')]]) }
    bmap { 'x', '\\i', '<esc>' .. mapstr('paqs.refactor', 'inline()') }
    bmap { 'x', '\\p', '<esc>' .. mapstr('paqs.refactor', 'print()') }

    bmap { 'n', '\\li', mapstr 'NullLsInfo' }
    bmap { 'n', '\\lI', mapstr 'LspInfo' }
end

local lspconfig = require 'lspconfig'

M.setup = function(server, ...)
    local settings = ...

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.offsetEncoding = { 'utf-16' }

    settings.capabilities = capabilities
    settings.on_attach = M.on_attach
    settings.flags = { debounce_text_changes = 0 }

    lspconfig[server].setup(settings)
end

return M
