local handlers = vim.lsp.handlers

vim.fn.sign_define(
    'DiagnosticSignError',
    { text = '>', texthl = 'DiagnosticError' }
)
vim.fn.sign_define(
    'DiagnosticSignWarn',
    { text = '—', texthl = 'DiagnosticWarn' }
)
vim.fn.sign_define(
    'DiagnosticSignHint',
    { text = '*', texthl = 'DiagnosticHint' }
)
vim.fn.sign_define(
    'DiagnosticSignInfo',
    { text = ':', texthl = 'DiagnosticInfo' }
)

handlers['textDocument/hover'] = vim.lsp.with(handlers.hover, {
    border = 'rounded',
})

handlers['textDocument/signatureHelp'] = vim.lsp.with(handlers.signature_help, {
    border = 'rounded',
    focusable = false,
})

local sources = {
    Pyright = 'pyright',
    Java = 'jdt',
    ['Lua Diagnostics.'] = 'sumneko',
    ['Lua Syntax Check.'] = 'sumneko',
}

vim.diagnostic.config {
    signs = false,
    severity_sort = true,
    update_in_insert = false,
    virtual_text = false,
    float = {
        border = 'rounded',
        format = function(diagnostic)
            return ('%s (%s)'):format(
                diagnostic.message,
                sources[diagnostic.source] or diagnostic.source
            )
        end,
        header = '',
    },
}
