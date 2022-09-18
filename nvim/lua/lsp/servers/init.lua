local noconfig_servers = {
    'cssls',
    'html',
    'jedi_language_server',
    'vimls',
}

local lspconfig = require 'lspconfig'
local prepare_lsp_settings = require('lsp.utils').prepare_lsp_settings

for _, server in ipairs(noconfig_servers) do
    lspconfig[server].setup(prepare_lsp_settings())
end

local servers = { 'jsonls', 'pyright', 'tailwindcss' }

for _, server in ipairs(servers) do
    local settings = require('lsp.servers.' .. server)
    lspconfig[server].setup(prepare_lsp_settings(settings))
end

lspconfig.sumneko_lua.setup(require 'lsp.servers.sumneko_lua')

require('clangd_extensions').setup {
    server = prepare_lsp_settings(require 'lsp.servers.clangd'),
    extensions = {
        autoSetHints = false,
        memory_usage = {
            border = 'single',
        },
    },
}

require('typescript').setup {
    server = prepare_lsp_settings(require 'lsp.servers.typescript'),
}
