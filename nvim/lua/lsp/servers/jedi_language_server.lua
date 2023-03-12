return {
    on_attach = function(client, _)
        -- Disable providers meant for pyright
        client.server_capabilities.definitionProvider = false
        client.server_capabilities.documentSymbolProvider = false
        client.server_capabilities.renameProvider = false
        client.server_capabilities.referencesProvider = false
        client.server_capabilities.typeDefinitionProvider = false
        client.server_capabilities.workspaceSymbolProvider = false
    end,
}
