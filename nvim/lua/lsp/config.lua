local handlers, methods = vim.lsp.handlers, vim.lsp.protocol.Methods

handlers[methods.textDocument_hover] = vim.lsp.with(handlers.hover, {
    border = 'single',
})

handlers[methods.textDocument_signatureHelp] =
    vim.lsp.with(handlers.signature_help, {
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
