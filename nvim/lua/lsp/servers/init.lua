local noconfig_servers = {
    'cssls',
    'html',
    'jsonls',
    'jedi_language_server',
    'vimls',
}

local utils = require 'lsp.utils'
local setup_lspconfig = utils.setup_lspconfig

for _, name in ipairs(noconfig_servers) do
    setup_lspconfig(name)
end

local servers = { 'clangd', 'pyright', 'sumneko_lua' }

for _, name in ipairs(servers) do
    local settings = require('lsp.servers.' .. name)
    setup_lspconfig(name, settings)
end

utils.setup_custom('typescript', require 'lsp.servers.typescript')
