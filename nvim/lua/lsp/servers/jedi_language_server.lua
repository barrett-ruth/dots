return {
    on_attach = function(client, bufnr)
        -- Disable providers meant for pyright
        client.server_capabilities.definitionProvider = false
        client.server_capabilities.documentSymbolProvider = false
        client.server_capabilities.referencesProvider = false
        client.server_capabilities.typeDefinitionProvider = false
        client.server_capabilities.workspaceSymbolProvider = false

        require('lsp.utils').on_attach(client, bufnr)
    end,
}
