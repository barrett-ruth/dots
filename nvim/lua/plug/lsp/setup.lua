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
        bmap { 'n', '<c-s>ti', mapstr 'TSLspToggleInlayHints' }
        bmap { 'n', '<c-s>tI', mapstr 'TSLspImportAll' }
        bmap { 'n', '<c-s>to', mapstr 'TSLspOrganize' }
    elseif client.name == 'clangd' then
        bmap { 'n', '<c-s>H', mapstr 'ClangdSwitchSourceHeader' }
    end

    bmap { 'n', ']<c-s>', mapstr 'lua vim.diagnostic.goto_next()' }
    bmap { 'n', '[<c-s>', mapstr 'lua vim.diagnostic.goto_prev()' }

    bmap { 'n', '<c-s>c', mapstr('telescope.builtin', 'lsp_code_actions()') }
    bmap { 'n', '<c-s>d', mapstr('telescope.builtin', 'lsp_definitions()') }
    bmap { 'n', '<c-s>i', mapstr('telescope.builtin', 'lsp_implementations()') }

    bmap {
        'n',
        '<c-s>sf',
        mapstr(
            'telescope.builtin',
            "lsp_document_symbols({ ignore_symbols = { 'property', 'variable', 'enummember', 'field' } })"
        ),
    }
    bmap { 'n', '<c-s>sa', mapstr('telescope.builtin', 'lsp_document_symbols()') }

    bmap { 'n', '<c-s>f', mapstr 'lua vim.diagnostic.open_float()' }
    bmap { 'n', '<c-s>h', mapstr 'lua vim.lsp.buf.hover()' }

    bmap { 'n', '<c-s>D', mapstr 'lua vim.lsp.buf.declaration()' }
    bmap { 'n', '<c-s>R', mapstr 'lua vim.lsp.buf.references()' }
    bmap { 'n', '<c-s>S', mapstr 'lua vim.lsp.buf.signature_help()' }

    if client.resolved_capabilities.rename then
        bmap { 'n', '<c-s>r', '<esc>' .. mapstr('plug.refactor', "setup_win('rename')") }
    end
    bmap { 'x', '<c-s>e', '<esc>' .. mapstr('plug.refactor', "setup_win('extract')") }
    bmap { 'x', '<c-s>i', '<esc>' .. mapstr('plug.refactor', 'inline()') }
    bmap { 'x', '<c-s>p', '<esc>' .. mapstr('plug.refactor', 'print()') }
    bmap { 'x', '<c-s>P', '<esc>' .. mapstr('plug.refactor', 'print(true)') }
end

local lspconfig = require 'lspconfig'

M.setup = function(server, ...)
    local settings = ...

    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.textDocument.completion.completionItem.snippetSupport = false
    capabilities.offsetEncoding = { 'utf-16' }

    settings.capabilities = capabilities
    settings.on_attach = M.on_attach
    settings.flags = { debounce_text_changes = 0 }

    lspconfig[server].setup(settings)
end

return M
