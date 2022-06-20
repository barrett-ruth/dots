vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'single',
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'single',
})

local sources = {
    Pyright = 'pyright',
    vimlsp = 'vimls',
}
sources['Lua Diagnostics.'] = 'luals'
sources['Lua Syntax Check.'] = 'luals'

vim.diagnostic.config {
    update_in_insert = true,
    virtual_text = false,
    signs = false,
    severity_sort = true,
    float = {
        header = '',
        prefix = '',
        border = 'single',
        format = function(diagnostic)
            local code = diagnostic.code or (diagnostic.user_data and diagnostic.user_data.code or '')
            local message = diagnostic.message
            local source = sources[diagnostic.source] or diagnostic.source

            if require('utils').empty(code) then
                return string.format('%s [%s]', message, source)
            else
                if source == 'pyright' then
                    code = code:gsub('report', ''):gsub('^%u', string.lower)
                end

                return string.format('%s [%s] [%s]', message, code, source)
            end
        end,
    },
}

-- Only show most severe sign
local ns = vim.api.nvim_create_namespace 'lsp_signs'
local dshow = vim.diagnostic.show

local function set_signs(bufnr)
    local diags = vim.diagnostic.get(bufnr)
    local line_severity = {}

    for _, d in pairs(diags) do
        local m = line_severity[d.lnum]
        if not m or d.severity < m.severity then
            line_severity[d.lnum] = d
        end
    end

    local fixed = vim.tbl_values(line_severity)
    dshow(ns, bufnr, fixed, {
        focus = false,
        priority = 0,
        signs = true,
    })
end

function vim.diagnostic.show(nsc, bufnr, ...)
    dshow(nsc, bufnr, ...)
    set_signs(bufnr)
end
