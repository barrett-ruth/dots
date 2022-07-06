local settings = {
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false

        require('lsp.utils').on_attach(client, bufnr)
    end,
    settings = {
        Lua = {
            diagnostics = { globals = { 'vim' } },
            runtime = {
                version = 'LuaJIT',
            },
        },
    },
}

return require('lua-dev').setup {
    lspconfig = require('lsp.utils').prepare_lsp_settings(settings),
}
