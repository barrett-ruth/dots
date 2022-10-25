local M = {}

M.on_attach = function(client, _)
    local utils = require 'utils'
    local bmap, mapstr = utils.bmap, utils.mapstr

    if client.server_capabilities.documentSymbolProvider then
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
                        [[lsp_document_symbols { fzf_opts = { ['--with-nth'] = '2..', ['--delimiter'] = ':' }, no_header = true, prompt = 'sym> ', %s }]],
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
            function()
                vim.cmd.w()
                utils.format()
            end,
        }
    end

    if client.server_capabilities.hoverProvider then
        bmap { 'n', '\\h', vim.lsp.buf.hover }
    end

    if client.server_capabilities.renameProvider then
        bmap { 'n', '\\r', utils.rename }
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
            bmap { 'n', '\\' .. k, mapstr('FzfLua lsp_' .. v[2]) }
        end
    end

    bmap { 'n', '<leader>fd', mapstr 'FzfLua lsp_workspace_diagnostics' }

    bmap { 'n', ']\\', vim.diagnostic.goto_next }
    bmap { 'n', '[\\', vim.diagnostic.goto_prev }
    bmap { 'n', '\\f', vim.diagnostic.open_float }

    bmap { 'n', '\\li', mapstr 'LspInfo' }
    bmap { 'n', '\\lI', mapstr 'NullLsInfo' }
    bmap { 'n', '\\ll', mapstr 'LspLog' }
    bmap { 'n', '\\lL', mapstr 'NullLsLog' }
    bmap { 'n', '\\lr', mapstr 'LspRestart' }
    bmap { 'n', '\\lR', mapstr 'NullLsRestart' }
end

M.prepare_lsp_settings = function(settings)
    local default_settings = {}
    default_settings.capabilities =
        require('cmp_nvim_lsp').default_capabilities(
            vim.lsp.protocol.make_client_capabilities()
        )
    default_settings.capabilities.offsetEncoding = { 'utf-16' }
    default_settings.capabilities.textDocument.completion.completionItem.snippetSupport =
        false
    default_settings.flags = { debounce_text_changes = 0 }
    default_settings.on_attach = M.on_attach

    return vim.tbl_extend('force', default_settings, settings)
end

return M
