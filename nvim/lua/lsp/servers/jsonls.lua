return {
    capabilities = {
        textDocument = {
            completion = {
                completionItem = { snippetSupport = true },
            },
        },
    },
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
        },
    },
}
