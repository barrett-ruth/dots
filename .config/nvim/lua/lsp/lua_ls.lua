return {
    settings = {
        Lua = {
            completion = { keywordSnippet = 'Disable' },
            diagnostics = { globals = { 'vim' } },
            hint = {
                enable = true,
                arrayIndex = 'Disable',
                semicolon = 'Disable',
            },
            runtime = { version = 'LuaJIT' },
            telemetry = { enable = false },
            workspace = {
                checkThirdParty = false,
            },
        },
    },
}
