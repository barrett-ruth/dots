require('neodev').setup({})

return {
    settings = {
        Lua = {
            completion = { keywordSnippet = 'Disable' },
            diagnostics = { globals = { 'vim' } },
            hint = {
                arrayIndex = 'Disable',
                enable = true,
                semicolon = 'Disable',
            },
            runtime = { version = 'LuaJIT' },
            telemetry = { enable = false },
            workspace = { checkThirdParty = false },
        },
    },
}
