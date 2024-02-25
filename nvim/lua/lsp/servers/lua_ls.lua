require('neodev').setup({})

return {
    settings = {
        Lua = {
            completion = { keywordSnippet = 'Disable' },
            diagnostics = { globals = { 'vim' } },
            format = { enable = false },
            hint = {
                enable = true,
                arrayIndex = 'Disable',
                semicolon = 'Disable',
            },
            runtime = { version = 'LuaJIT' },
            telemetry = { enable = false },
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file('', true),
            },
        },
    },
}
