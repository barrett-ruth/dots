require('neodev').setup {}

return {
    settings = {
        Lua = {
            completion = { keywordSnippet = 'Disable' },
            diagnostics = { globals = { 'vim' }, workspaceDelay = -1 },
            runtime = {
                version = 'LuaJIT',
            },
            telemetry = { enable = false },
        },
    },
}
