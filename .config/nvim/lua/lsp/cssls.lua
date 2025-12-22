return {
    settings = {
        css = {
            lint = {
                unknownAtRules = 'ignore',
            },
        },
    },
    capabilities = {
        textDocument = {
            completion = {
                completionItem = { snippetSupport = true },
            },
        },
    },
}
