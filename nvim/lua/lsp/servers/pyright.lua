return {
    on_attach = function(client, _)
        -- Disable providers meant for pylsp
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
