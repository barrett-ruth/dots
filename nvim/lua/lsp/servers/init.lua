local noconfig_servers = {
    'cssls',
    'html',
    'jedi_language_server',
    'vimls',
}

local utils = require 'lsp.utils'
local prepare_lsp_settings, setup_lspconfig =
utils.prepare_lsp_settings, utils.setup_lspconfig

for _, server in ipairs(noconfig_servers) do
    setup_lspconfig(server)
end

local servers = { 'clangd', 'jsonls', 'pyright' }

for _, server in ipairs(servers) do
    local settings = require('lsp.servers.' .. server)
    setup_lspconfig(server, prepare_lsp_settings(settings))
end

setup_lspconfig('sumneko_lua', require 'lsp.servers.sumneko_lua')

require('typescript').setup {
    server = prepare_lsp_settings(require 'lsp.servers.typescript'),
}
