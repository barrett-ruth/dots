local M = {}

M.on_attach = function(client, bufnr)
    if vim.wo.signcolumn == 'no' then vim.wo.signcolumn = 'yes:1' end

    local utils = require 'utils'
    local bmap, mapstr = utils.bmap, utils.mapstr

    if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
        for k, v in pairs {
            a = [[query = '!const !enumm !field !prop !var !( ']],
            c = [[regex_filter = 'Class.*']],
            f = [[regex_filter = 'Function.*']],
            m = [[regex_filter = 'Module.*']],
        } do
            bmap {
                'n',
                '\\s' .. k,
                mapstr(
                    'fzf-lua',
                    string.format(
                        [[lsp_document_symbols { fzf_opts = { ['--with-nth'] = '2..', ['--delimiter'] = ':' }, no_header = true, prompt = 'sym> ', %s } ]],
                        v
                    )
                ),
            }
        end
    end

    if client.server_capabilities.documentFormattingProvider then
        bmap {
            'n',
            '<leader>w',
            mapstr 'w' .. mapstr('utils', 'format()'),
        }
    end

    if client.server_capabilities.hoverProvider then
        bmap { 'n', '\\h', mapstr 'lua vim.lsp.buf.hover()' }
    end

    if client.server_capabilities.renameProvider then
        bmap { 'n', '\\r', mapstr 'lua vim.lsp.buf.rename()' }
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

    bmap { 'n', '<leader>fd', mapstr 'FzfLua lsp_workspace_diagnostics' }

    bmap { 'n', ']\\', mapstr 'lua vim.diagnostic.goto_next()' }
    bmap { 'n', '[\\', mapstr 'lua vim.diagnostic.goto_prev()' }
    bmap { 'n', '\\f', mapstr 'lua vim.diagnostic.open_float()' }

    bmap { 'n', '\\li', mapstr 'LspInfo' }
    bmap { 'n', '\\lI', mapstr 'NullLsInfo' }
    bmap { 'n', '\\ll', mapstr 'LspLog' }
    bmap { 'n', '\\lr', mapstr 'LspRestart' }
    bmap { 'n', '\\lR', mapstr 'NullLsRestart' }

    bmap { 'n', '\\lt', mapstr('lsp_lines', 'toggle()') }
end

M.prepare_lsp_settings = function(settings)
    local default_settings = {}
    default_settings.capabilities = require('cmp_nvim_lsp').update_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    )
    default_settings.capabilities.offsetEncoding = { 'utf-16' }
    default_settings.capabilities.textDocument.completion.completionItem.snippetSupport =
        false
    default_settings.flags = { debounce_text_changes = 0 }
    default_settings.on_attach = M.on_attach

    return vim.tbl_extend('force', default_settings, settings or {})
end

return M
