local handlers, methods = vim.lsp.handlers, vim.lsp.protocol.Methods

handlers['textDocument/hover'] = vim.lsp.with(handlers.hover, {
    border = 'single',
})

handlers['textDocument/signatureHelp'] = vim.lsp.with(handlers.signature_help, {
    border = 'single',
    focusable = false,
})

vim.diagnostic.config({
    signs = false,
    float = {
        border = 'single',
        format = function(diagnostic)
            return ('%s (%s)'):format(diagnostic.message, diagnostic.source)
        end,
        header = '',
        prefix = ' ',
    },
    virtual_text = {
        format = function(diagnostic)
            return vim.split(diagnostic.message, '\n')[1]
        end,
    },
})

-- TODO: remove once https://github.com/neovim/neovim/issues/27240 addressed
local MAX_INLAY_HINT_LEN = 30
local inlay_hint_handler = vim.lsp.handlers[methods.textDocument_inlayHint]
vim.lsp.handlers[methods.textDocument_inlayHint] = function(
    err,
    result,
    ctx,
    config
)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if client then
        result = vim.iter.map(function(hint)
            local label = hint.label ---@type string
            if label:len() >= MAX_INLAY_HINT_LEN then
                label = label:sub(1, MAX_INLAY_HINT_LEN) .. '...'
            end
            hint.label = label
            return hint
        end, result)
    end

    inlay_hint_handler(err, result, ctx, config)
end
