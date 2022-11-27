return {
    on_attach = function(client, _)
        -- Disable providers meant for jedi_language_server
        client.server_capabilities.hoverProvider = false

        require('lsp.utils').on_attach(client, _)
    end,
    settings = {
        python = {
            analysis = {
                typeCheckingMode = 'off',
            },
        },
    },
}
