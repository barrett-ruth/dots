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
