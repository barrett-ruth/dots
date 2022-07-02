local M = {}

M.on_attach = function(client, bufnr)
    local signcolumn = vim.wo.signcolumn
    if signcolumn == 'no' then
        vim.wo.signcolumn = 'yes:1'
    end

    local utils = require 'utils'
    local bmap, mapstr = utils.bmap, utils.mapstr

    if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
        for k, v in pairs {
            a = '',
            f = 'Function',
            c = 'Class',
            m = 'Module',
        } do
            bmap {
                'n',
                '\\s' .. k,
                mapstr(
                    'fzf-lua',
                    string.format(
                        [[lsp_document_symbols { fzf_opts = { ['--with-nth'] = '2..', ['--delimiter'] = ':' }, prompt = 'sym> ', regex_filter = '%s.*' } ]]
                        ,
                        v
                    )
                ),
            }
        end
    end

    if client.server_capabilities.codeLensProvider then
        vim.lsp.codelens.display()
    end

    if client.server_capabilities.hoverProvider then
        bmap { 'n', '\\h', mapstr 'lua vim.lsp.buf.hover()' }
    end

    if client.server_capabilities.renameProvider then
        bmap { 'n', '\\r', '<esc>' .. mapstr('paqs.refactor', 'rename()') }
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

    bmap { 'x', '\\e', '<esc>' .. mapstr('paqs.refactor', 'extract()') }
    bmap { 'x', '\\p', '<esc>' .. mapstr('paqs.refactor', 'print()') }

    bmap { 'n', '\\li', mapstr 'LspInfo' }
    bmap { 'n', '\\lI', mapstr 'NullLsInfo' }
    bmap { 'n', '\\lr', mapstr 'LspRestart' }
    bmap { 'n', '\\lR', mapstr 'NullLsRestart' }
end

local lspconfig = require 'lspconfig'

M.setup = function(server, settings)
    settings = settings or {}
    settings.capabilities = require('cmp_nvim_lsp').update_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    )
    settings.capabilities.offsetEncoding = { 'utf-16' }
    settings.capabilities.textDocument.completion.completionItem.snippetSupport = false
    settings.flags = { debounce_text_changes = 0 }
    settings.on_attach = settings.on_attach or M.on_attach

    lspconfig[server].setup(settings)
end

return M
