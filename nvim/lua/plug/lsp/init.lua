require 'plug.lsp.signs'

local servers = {
    clangd = {},
    cssls = {},
    dockerls = {},
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
    yamlls = {},
}

local setup = require 'plug.lsp.setup'
local lsp_setup = setup.setup
local on_attach = setup.on_attach

for name, info in pairs(servers) do
    lsp_setup(name, info)
end

local null_ls = require 'null-ls'
local builtins = null_ls.builtins

null_ls.setup {
    update_in_insert = true,
    sources = {
        builtins.diagnostics.eslint_d,
        builtins.diagnostics.mypy,
        builtins.diagnostics.shellcheck.with { diagnostics_format = '#{m} [#{c}]' },
    },
    on_attach = on_attach,
    debounce = 0,
}
