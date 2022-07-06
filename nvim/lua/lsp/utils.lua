local M = {}

M.on_attach = function(client, bufnr)
    if vim.wo.signcolumn == 'no' then
        vim.wo.signcolumn = 'yes:1'
    end

    local utils = require 'utils'
    local bmap, mapstr = utils.bmap, utils.mapstr

    if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
        for k, v in pairs {
            a = [[query = '!EnumMember ']],
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
                        [[lsp_document_symbols { fzf_opts = { ['--with-nth'] = '2..', ['--delimiter'] = ':' }, no_header = true, prompt = 'sym> ', %s } ]]
                        ,
                        v
                    )
                ),
            }
        end
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

    bmap { 'n', '<leader>fd', mapstr 'FzfLua lsp_workspace_diagnostics' }

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

M.prepare_lsp_settings = function(settings)
    settings = settings or {}
    settings.capabilities = vim.lsp.protocol.make_client_capabilities()
    local generic_settings = {
        capabilities = {
            offsetEncoding = { 'utf-16' },
        },
        flags = { debounce_text_changes = 0 },
        on_attach = M.on_attach,
    }

    return vim.tbl_extend('force', generic_settings, settings)
end

M.setup_lspconfig = function(server, settings)
    settings = settings or M.prepare_lsp_settings {}
    lspconfig[server].setup(settings)
end

return M
