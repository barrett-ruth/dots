local noconfig_servers = {
    'cssls',
    'html',
    'jsonls',
    'jedi_language_server',
    'vimls',
}

local setup = require('lsp.utils').setup

for _, name in ipairs(noconfig_servers) do
    setup(name)
end

local servers = { 'clangd', 'pyright', 'sumneko_lua', 'tsserver' }

for _, name in ipairs(servers) do
    local settings = require('lsp.servers.' .. name)
    setup(name, settings)
end
