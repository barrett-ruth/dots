return {
    on_attach = function(client, bufnr)
        -- Disable providers meant for pyright
        client.server_capabilities.documentSymbolProvider = false

        require('lsp.utils').on_attach(client, bufnr)
    end,
}
