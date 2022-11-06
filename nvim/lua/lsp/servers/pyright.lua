return {
    on_attach = function(client, bufnr)
        -- Disable providers meant for jedi_language_server
        client.server_capabilities.hoverProvider = false

        require('lsp.utils').on_attach(client, bufnr)
    end,
    settings = {
        venvPath = '.',
        venv = 'venv',
        python = {
            analysis = {
                typeCheckingMode = 'off',
            },
        },
    },
}
