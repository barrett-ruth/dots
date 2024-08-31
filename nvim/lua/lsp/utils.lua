local M = {}

function M.on_attach(client, bufnr)
    local diagnostic, buf = vim.diagnostic, vim.lsp.buf

    local mappings = {
        codeAction = {
            { 'n', 'x' },
            'gra',
            buf.code_action,
        },
        hover = { 'n', 'K', buf.hover },
        inlayHint = {
            'n',
            '\\i',
            function()
                vim.lsp.inlay_hint(bufnr)
            end,
        },
        signatureHelp = {
            'i',
            '<c-space>',
            buf.signature_help,
        },
    }

    vim.print('running mappings')
    for provider, mapping in pairs(mappings) do
        if client.server_capabilities[('%sProvider'):format(provider)] then
            bmap(mapping)
        end
    end

    if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
    end

    bmap({ 'n', '\\f', diagnostic.open_float })
    bmap({
        'n',
        '\\t',
        function()
            local level = vim.lsp.log.get_level()
            vim.lsp.log.set_level(
                vim.lsp.log_levels[level] == 'WARN' and 'OFF' or 'WARN'
            )
        end,
    })
    bmap({
        'n',
        ']\\',
        function()
            diagnostic.jump({ count = 1, float = true })
        end,
    })
    bmap({
        'n',
        '[\\',
        function()
            diagnostic.jump({ count = -1, float = true })
        end,
    })
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
