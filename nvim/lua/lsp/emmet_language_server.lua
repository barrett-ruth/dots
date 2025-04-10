return {
    init_options = {
        showSuggestionsAsSnippets = true,
    },
    capabilities = {
        textDocument = {
            completion = {
                completionItem = { snippetSupport = true },
            },
        },
    },
}
