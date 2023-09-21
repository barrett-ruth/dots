local lsp = vim.lsp

lsp.handlers[lsp.protocol.Methods.textDocument_hover] =
    lsp.with(lsp.handlers.hover, {
        border = 'single',
    })

lsp.handlers[lsp.protocol.Methods.textDocument_signatureHelp] =
    lsp.with(lsp.handlers.signature_help, {
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
