local M = {}

local deny_format = { tsserver = true, clangd = true, sumneko_lua = true, jsonls = true, vimls = true }

M.on_attach = function(client, bufnr)
    if client.server_capabilities.codeLensProdiver then
        vim.lsp.codelens.display()
    end

    if client.server_capabilities.documentSymbolProvider and not vim.tbl_contains(NAVIC_DEPRECATED, vim.bo.ft) then
        require('nvim-navic').attach(client, bufnr)
    end

    local utils = require 'utils'
    local bmap, mapstr = utils.bmap, utils.mapstr

    if deny_format[client.name] then
        client.server_capabilities.documentFormattingProvider = false
        for k, v in pairs { a = '', f = 'Function', c = 'Class', m = 'Module' } do
            bmap {
                'n',
                '\\s' .. k,
                mapstr(
                    'fzf-lua',
                    string.format(
                        [[lsp_document_symbols { fzf_opts = { ['--with-nth'] = '2..', ['--delimiter'] = ':' }, prompt = 'sym> ', regex_filter = '%s.*' } ]],
                        v
                    )
                ),
            }
        end
    end

    if client.name == 'tsserver' then
        local ts_utils = require 'nvim-lsp-ts-utils'

        ts_utils.setup {
            auto_inlay_hints = false,
            enable_import_on_completion = true,
            update_imports_on_move = true,
        }

        ts_utils.setup_client(client)

        bmap { 'n', '\\Ti', mapstr 'TSLspImportAll' }
        bmap { 'n', '\\To', mapstr 'TSLspOrganize' }
    elseif client.name == 'clangd' then
        bmap { 'n', '\\H', mapstr 'ClangdSwitchSourceHeader' }
    end

    if client.server_capabilities.hoverProvider then
        bmap { 'n', '\\h', mapstr 'lua vim.lsp.buf.hover()' }
    end

    if client.server_capabilities.renameProvider then
        bmap { 'n', '\\r', '<esc>' .. mapstr('paqs.refactor', [[setup_win('rename')]]) }
    end

    for k, v in pairs {
        c = { 'codeAction', 'code_actions' },
        d = { 'definition', 'definitions' },
        D = { 'declaration', 'declarations' },
        i = { 'implementation', 'implementations' },
        R = { 'references', 'references' },
        t = { 'typeDefinition', 'typedefs' },
    } do
        if client.server_capabilities[v[1] .. 'Provider'] then
            bmap { 'n', '\\' .. k, mapstr('fzf-lua', 'lsp_' .. v[2] .. '()') }
        end
    end

    bmap { 'n', ']\\', mapstr 'lua vim.diagnostic.goto_next()' }
    bmap { 'n', '[\\', mapstr 'lua vim.diagnostic.goto_prev()' }
    bmap { 'n', '\\f', mapstr 'lua vim.diagnostic.open_float()' }

    bmap { 'x', '\\e', '<esc>' .. mapstr('paqs.refactor', [[setup_win('extract')]]) }
    bmap { 'x', '\\i', '<esc>' .. mapstr('paqs.refactor', 'inline()') }
    bmap { 'x', '\\p', '<esc>' .. mapstr('paqs.refactor', 'print()') }

    bmap { 'n', '\\li', mapstr 'LspInfo' }
    bmap { 'n', '\\lI', mapstr 'NullLsInfo' }
    bmap { 'n', '\\lr', mapstr 'LspRestart' }
    bmap { 'n', '\\lR', mapstr 'NullLsRestart' }
end

local lspconfig = require 'lspconfig'

M.setup = function(server, ...)
    local settings = ...

    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.offsetEncoding = { 'utf-16' }
    capabilities.textDocument.completion.completionItem.snippetSupport = false

    settings.capabilities = capabilities
    settings.on_attach = M.on_attach
    settings.flags = { debounce_text_changes = 0 }

    lspconfig[server].setup(settings)
end

return M
