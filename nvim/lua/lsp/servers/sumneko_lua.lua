return {
    settings = {
        Lua = {
            completion = { keywordSnippet = 'Disable' },
            diagnostics = { globals = { 'vim' } },
            runtime = {
                version = 'LuaJIT',
            },
        },
    },
}
