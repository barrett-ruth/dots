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

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'single',
})

vim.lsp.handlers['textDocument/signatureHelp'] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = 'single',
    })

local sources = {
    vimlsp = 'vimls',
    Pyright = 'pyright',
    Java = 'jdt',
    ['Lua Diagnostics.'] = 'luals',
    ['Lua Syntax Check.'] = 'luals',
}

vim.diagnostic.config {
    update_in_insert = false,
    virtual_text = false,
    signs = false,
    severity_sort = true,
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
                return string.format('%s (%s)', message, source)
            else
                if source == 'pyright' then
                    code = code:gsub('report', ''):gsub('^%u', string.lower, 1)
                end

                return string.format('%s [%s] (%s)', message, code, source)
            end
        end,
    },
}

-- Only show most sever diagnostics
local ns = vim.api.nvim_create_namespace 'lsp-signs'

-- Get a reference to the original signs handler
local orig_signs_handler = vim.diagnostic.handlers.signs

-- Override the built-in signs handler
vim.diagnostic.handlers.signs = {
    show = function(_, bufnr, _, opts)
        -- Get all diagnostics from the whole buffer rather than just the
        -- diagnostics passed to the handler
        local diagnostics = vim.diagnostic.get(bufnr)

        -- Find the "worst" diagnostic per line
        local max_severity_per_line = {}
        for _, d in pairs(diagnostics) do
            local m = max_severity_per_line[d.lnum]
            if not m or d.severity < m.severity then
                max_severity_per_line[d.lnum] = d
            end
        end

        local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
        orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
    end,
    hide = function(_, bufnr) orig_signs_handler.hide(ns, bufnr) end,
}
