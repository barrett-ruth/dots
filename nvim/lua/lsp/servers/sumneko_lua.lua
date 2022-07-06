local settings = {
    settings = {
        Lua = {
            diagnostics = { globals = { 'vim' } },
            runtime = {
                version = 'LuaJIT',
            },
        },
    },
}

return require('lua-dev').setup {
    lspconfig = require('lsp.utils').prepare_lsp_settings(settings),
}
