require('neodev').setup({})

return {
    settings = {
        Lua = {
            completion = { keywordSnippet = 'Disable' },
            diagnostics = { globals = { 'vim' } },
            runtime = { version = 'LuaJIT' },
            telemetry = { enable = false },
            workspace = { checkThirdParty = false },
        },
    },
}
