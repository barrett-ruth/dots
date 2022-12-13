local fn = vim.fn

fn.sign_define(
    'DiagnosticSignError',
    { text = '>', texthl = 'DiagnosticError' }
)
fn.sign_define(
    'DiagnosticSignWarn',
    { text = '—', texthl = 'DiagnosticWarn' }
)
fn.sign_define('DiagnosticSignHint', { text = '*', texthl = 'DiagnosticHint' })
fn.sign_define('DiagnosticSignInfo', { text = ':', texthl = 'DiagnosticInfo' })

local lsp = vim.lsp
local handlers = lsp.handlers

handlers['textDocument/hover'] = lsp.with(handlers.hover, {
    border = 'rounded',
    focusable = false,
})

handlers['textDocument/signatureHelp'] = lsp.with(handlers.signature_help, {
    border = 'rounded',
    focusable = false,
})

local sources = {
    Pyright = 'pyright',
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
            return ('%s (%s)'):format(diagnostic.message, sources[diagnostic.source] or diagnostic.source)
        end,
        header = '',
    },
}
