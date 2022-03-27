require 'plug.lsp.signs'

local null_ls = require 'null-ls'
local builtins = null_ls.builtins

null_ls.setup {
    sources = {
        builtins.diagnostics.shellcheck,
    },
    update_in_insert = true,
    diagnostics_format = '#{m} [#{c}]',
}

local servers = {
    clangd = {},
    cssls = {},
    dockerls = {},
    eslint = {},
    html = {},
    jsonls = {},
    pyright = {},
    sumneko_lua = {
        settings = {
            Lua = {
                completion = { keywordSnippet = 'Disable' },
                diagnostics = { globals = { 'vim' } },
            },
        },
    },
    tsserver = {},
    vimls = {},
}

local setup = require('plug.lsp.setup').setup

for name, info in pairs(servers) do
    setup(name, info)
end
