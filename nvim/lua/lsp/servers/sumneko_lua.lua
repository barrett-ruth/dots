local settings = {
    settings = {
        Lua = {
            completion = { keywordSnippet = 'Disable' },
            diagnostics = { globals = { 'vim' } },
            runtime = {
                version = 'LuaJIT',
            },
        },
    },
    capabilities = {
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = false,
                },
            },
        },
    },
}

return require('lua-dev').setup {
    lspconfig = require('lsp.utils').prepare_lsp_settings(settings),
}
