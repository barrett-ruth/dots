local servers = {
    'clangd',
    'cssmodules_ls',
    'cssls',
    'html',
    'jedi_language_server',
    'jsonls',
    'pyright',
    'sqls',
    'sumneko_lua',
    'tailwindcss',
    'vimls',
}

local lspconfig = require 'lspconfig'

local prepare_lsp_settings = require('lsp.utils').prepare_lsp_settings

for _, server in ipairs(servers) do
    local status, settings = pcall(require, 'lsp.servers.' .. server)

    if not status then
        settings = {}
    end

    lspconfig[server].setup(prepare_lsp_settings(settings))
end

require('typescript').setup {
    server = prepare_lsp_settings(require 'lsp.servers.typescript'),
}
