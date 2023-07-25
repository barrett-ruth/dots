local M = {}

function M.on_attach()
    local diagnostic, buf = vim.diagnostic, vim.lsp.buf

    bmap({ { 'n', 'x' }, '\\c', buf.code_action })
    bmap({ 'n', '\\f', diagnostic.open_float })
    bmap({ 'n', 'K', buf.hover })
    bmap({ 'n', 'gD', buf.declaration })
    bmap({ 'n', 'gr', require('lsp.rename').rename })

    bmap({ 'n', ']\\', diagnostic.goto_next })
    bmap({ 'n', '[\\', diagnostic.goto_prev })

    bmap({ 'i', '<c-space>', buf.signature_help })
end

function M.prepare_lsp_settings(user_settings)
    local settings = {}

    settings.capabilities = require('cmp_nvim_lsp').default_capabilities()
    settings.capabilities.offsetEncoding = { 'utf-16' }
    settings.capabilities.textDocument.completion.completionItem.snippetSupport =
        false

    settings.flags = { debounce_text_changes = 0 }

    settings = vim.tbl_extend('force', settings, user_settings)

    settings.on_attach = function(...)
        if user_settings.on_attach then
            user_settings.on_attach(...)
        end

        M.on_attach()
    end

    return settings
end

return M
