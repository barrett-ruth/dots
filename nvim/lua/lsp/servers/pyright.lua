return {
    on_attach = function(client, _)
        -- Disable providers meant for jedi_language_server
        client.server_capabilities.definitionProvider = false
        client.server_capabilities.referencesProvider = false
        client.server_capabilities.hoverProvider = false
    end,
    settings = {
        python = {
            analysis = {
                typeCheckingMode = 'off',
            },
        },
    },
}
