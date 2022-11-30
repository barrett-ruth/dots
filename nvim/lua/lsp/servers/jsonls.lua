return {
    capabilities = {
        textDocument = {
            completion = {
                completionItem = { snippetSupport = true },
            },
        },
    },
    on_attach = function(client, _)
        -- Disable providers meant for jedi_language_server
        client.server_capabilities.hoverProvider = false

        require('lsp.utils').on_attach(client, _)
    end,
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
        },
    },
}
