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

    bmap { 'n', '\\l', mapstr 'lua vim.diagnostic.setloclist()' }
    bmap { 'n', '\\q', mapstr 'lua vim.diagnostic.setqflist()' }

    bmap { 'n', '\\Li', mapstr 'LspInfo' }
    bmap { 'n', '\\LI', mapstr 'NullLsInfo' }
    bmap { 'n', '\\Lr', mapstr 'LspRestart' }
    bmap { 'n', '\\LR', mapstr 'NullLsRestart' }
end

local lspconfig = require 'lspconfig'

M.prepare_lsp_settings = function(settings)
    settings = settings or {}
    settings.capabilities = require('cmp_nvim_lsp').update_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    )
    settings.capabilities.offsetEncoding = { 'utf-16' }
    settings.capabilities.textDocument.completion.completionItem.snippetSupport = false
    settings.flags = { debounce_text_changes = 0 }
    settings.on_attach = settings.on_attach or M.on_attach

    return settings
end

M.setup_lspconfig = function(server, settings)
    local lspconfig_settings = M.prepare_lsp_settings(settings)

    lspconfig[server].setup(lspconfig_settings)
end

M.setup_custom = function(server, settings)
    local lspconfig_settings = M.prepare_lsp_settings(settings)

    require(server).setup { server = lspconfig_settings }
end

return M
