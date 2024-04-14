local M = {}

function M.on_attach(client, bufnr)
    local diagnostic, buf = vim.diagnostic, vim.lsp.buf

    local mappings = {
        codeAction = {
            { 'n', 'x' },
            '\\c',
            buf.code_action,
        },
        declaration = { 'n', 'gD', buf.declaration },
        hover = { 'n', 'K', buf.hover },
        inlayHint = {
            'n',
            '\\i',
            function()
                vim.lsp.inlay_hint(bufnr)
            end,
        },
        rename = {
            'n',
            'gr',
            require('lsp.rename').rename,
        },
        signatureHelp = {
            'i',
            '<c-space>',
            buf.signature_help,
        },
    }

    for provider, mapping in pairs(mappings) do
        if client.server_capabilities[('%sProvider'):format(provider)] then
            bmap(mapping)
        end
    end

    if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
    end

    if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
    end

    bmap({ 'n', '\\f', diagnostic.open_float })
    bmap({ 'n', ']\\', diagnostic.goto_next })
    bmap({ 'n', '[\\', diagnostic.goto_prev })
end

function M.prepare_lsp_settings(user_settings)
    local settings = {}

    settings.capabilities = require('cmp_nvim_lsp').default_capabilities()
    settings.capabilities.offsetEncoding = { 'utf-16' }
    settings.capabilities.textDocument.completion.completionItem.snippetSupport =
        false

    settings.flags = { debounce_text_changes = 0 }

    settings = vim.tbl_extend('force', settings, user_settings or {})

    settings.on_attach = function(...)
        if user_settings.on_attach then
            user_settings.on_attach(...)
        end

        M.on_attach(...)
    end

    return settings
end

return M
