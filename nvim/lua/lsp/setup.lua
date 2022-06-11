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

    bmap { 'n', '\\sa', mapstr('fzf-lua', 'lsp_document_symbols()') }
    for k, v in pairs { f = '', c = 'ﴯ', m = '' } do
        bmap {
            'n',
            '\\s' .. k,
            mapstr('fzf-lua', string.format([[lsp_document_symbols({ fzf_args = "-s --query='[%s] '" })]], v)),
        }
    end

    bmap { 'n', ']\\', mapstr 'lua vim.diagnostic.goto_next()' }
    bmap { 'n', '[\\', mapstr 'lua vim.diagnostic.goto_prev()' }

    bmap { 'n', '\\c', mapstr 'lua vim.lsp.buf.code_action()' }
    bmap { 'n', '\\d', mapstr 'lua vim.lsp.buf.definition()' }
    bmap { 'n', '\\D', mapstr 'lua vim.lsp.buf.declaration()' }
    bmap { 'n', '\\f', mapstr 'lua vim.diagnostic.open_float()' }
    bmap { 'n', '\\h', mapstr 'lua vim.lsp.buf.hover()' }
    bmap { 'n', '\\i', mapstr 'lua vim.lsp.buf.implementation()' }
    bmap { 'n', '\\R', mapstr 'lua vim.lsp.buf.references()' }

    bmap { 'n', '\\r', '<esc>' .. mapstr('plug.refactor', [[setup_win('rename')]]) }
    bmap { 'x', '\\e', '<esc>' .. mapstr('plug.refactor', [[setup_win('extract')]]) }
    bmap { 'x', '\\i', '<esc>' .. mapstr('plug.refactor', 'inline()') }
    bmap { 'x', '\\p', '<esc>' .. mapstr('plug.refactor', 'print()') }
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
