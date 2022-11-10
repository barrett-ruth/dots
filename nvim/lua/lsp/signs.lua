local diagnostic_signs = {
    Error = { text = '>' },
    Warn = { text = '—' },
    Hint = { text = '*' },
    Info = { text = ':' },
}

for name, v in pairs(diagnostic_signs) do
    vim.fn.sign_define(
        'DiagnosticSign' .. name,
        { text = v.text, texthl = 'Diagnostic' .. name }
    )
end

local lsp = vim.lsp
local handlers = lsp.handlers

handlers['textDocument/hover'] = lsp.with(handlers.hover, {
    border = 'single',
})

handlers['textDocument/signatureHelp'] = lsp.with(handlers.signature_help, {
    border = 'single',
    focusable = false
})

local sources = {
    Pyright = 'pyright',
    ['Lua Diagnostics.'] = 'luals',
    ['Lua Syntax Check.'] = 'luals',
}

vim.diagnostic.config {
    signs = false,
    severity_sort = true,
    update_in_insert = false,
    virtual_text = false,
    float = {
        header = '',
        prefix = '',
        border = 'single',
        format = function(diagnostic)
            local code = diagnostic.code
                or (diagnostic.user_data and diagnostic.user_data.code or '')
            local message = diagnostic.message
            local source = sources[diagnostic.source] or diagnostic.source

            if require('utils').empty(code) then
                return ('> %s (%s)'):format(message, source)
            else
                if source == 'pyright' then
                    code = code:gsub('report', ''):gsub('^%u', string.lower, 1)
                end

                return ('> %s [%s] (%s)'):format(message, code, source)
            end
        end,
    },
}
