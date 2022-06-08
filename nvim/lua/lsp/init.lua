require 'lsp.signs'

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
                runtime = {
                    version = 'LuaJIT',
                },
                completion = { keywordSnippet = 'Disable' },
                diagnostics = { globals = { 'vim' } },
            },
        },
    },
    tsserver = {
        init_options = require('nvim-lsp-ts-utils').init_options,
    },
    vimls = {},
}

local setup = require 'lsp.setup'
local lsp_setup, on_attach = setup.setup, setup.on_attach

for name, info in pairs(servers) do
    lsp_setup(name, info)
end

local null_ls = require 'null-ls'
local builtins = null_ls.builtins

null_ls.setup {
    sources = {
        builtins.diagnostics.curlylint.with {
            diagnostics_format = '#{m}',
            extra_filetypes = { 'html' },
        },
        builtins.diagnostics.eslint_d.with {
            condition = function(utils)
                return utils.root_has_file {
                    { '.eslintrc', '.eslintrc.cjs', '.eslintrc.yaml', '.eslintrc.yml', '.eslintrc.json' },
                }
            end,
            diagnostics_format = '#{m}',
        },
        builtins.diagnostics.flake8.with {
            condition = function()
                return vim.fn.executable 'flake8'
            end,
            diagnostics_format = '#{m}',
        },
        builtins.diagnostics.mypy.with {
            condition = function()
                return vim.fn.executable 'mypy'
            end,
        },
        builtins.diagnostics.shellcheck.with {
            diagnostics_format = '#{m}',
        },

        builtins.formatting.black.with {
            condition = function()
                return vim.fn.executable 'black'
            end,
            extra_args = { '-S', '--fast' },
        },
        builtins.formatting.clang_format,
        builtins.formatting.prettierd,
        builtins.formatting.shfmt.with {
            extra_args = { '-i', '4', '-ln=posix' },
        },
        builtins.formatting.stylua.with {
            extra_args = { '--config-path', vim.fn.expand '~/.config/templates/stylua.toml' },
        },
    },
    update_in_insert = true,
    diagnostics_format = '#{m} [#{c}]',
    on_attach = on_attach,
    debounce = 0,
}