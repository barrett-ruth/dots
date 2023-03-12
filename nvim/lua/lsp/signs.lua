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
    border = 'single',
})

handlers['textDocument/signatureHelp'] = vim.lsp.with(handlers.signature_help, {
    border = 'single',
    focusable = false,
})

local sources = {
    Pyright = 'pyright',
    ['Lua Diagnostics.'] = 'lua',
    ['Lua Syntax Check.'] = 'lua',
}

vim.diagnostic.config {
    signs = false,
    severity_sort = true,
    update_in_insert = false,
    virtual_text = false,
    float = {
        border = 'single',
        format = function(diagnostic)
            return ('%s (%s)'):format(
                diagnostic.message,
                sources[diagnostic.source] or diagnostic.source
            )
        end,
        header = '',
    },
}
