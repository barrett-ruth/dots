require('lua-dev').setup {}

return {
    settings = {
        capabilities = {
            textDocument = {
                completion = {
                    completionItem = {
                        snippetSupport = false,
                    },
                },
            },
        },
        settings = {
            Lua = {
                completion = { keywordSnippet = 'Disable' },
                diagnostics = { globals = { 'vim' } },
                runtime = {
                    version = 'LuaJIT',
                },
            },
        },
    },
}
