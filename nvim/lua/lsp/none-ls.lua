local on_attach = require('lsp.utils').on_attach

local null_ls = require('null-ls')
local builtins = null_ls.builtins
local code_actions, diagnostics, formatting =
    builtins.code_actions, builtins.diagnostics, builtins.formatting

null_ls.setup({
    sources = {
        code_actions.gitrebase,
        code_actions.gitsigns,

        diagnostics.djlint,
        diagnostics.hadolint,
        diagnostics.markdownlint.with({
            extra_args = { '--disable', 'MD033', 'MD013' },
        }),
        diagnostics.mypy.with({
            extra_args = { '--check-untyped-defs' },
            runtime_condition = function(params)
                return require('null-ls.utils').path.exists(params.bufname)
            end,
        }),
        diagnostics.selene,
        diagnostics.sqlfluff.with({
            extra_args = {
                '--dialect',
                'postgres',
                '--exclude-rules',
                'LT02,LT05', -- indent, line length
            },
        }),
        diagnostics.yamllint,

        formatting.blackd.with({ extra_args = { '--fast' } }),
        formatting.isort.with({ extra_args = { '--profile', 'black' } }),

        formatting.cbfmt.with({
            condition = function(utils)
                return utils.root_has_file({ '.cbfmt.toml' })
            end,
        }),
        formatting.google_java_format,
        formatting.gofumpt,
        formatting.goimports_reviser,
        formatting.golines,
        formatting.prettierd.with({
            env = {
                XDG_RUNTIME_DIR = vim.env.XDG_RUNTIME_DIR
                    or (vim.env.XDG_DATA_HOME .. '/prettierd'),
            },
            filetypes = {
                'css',
                'graphql',
                'html',
                'javascript',
                'javascriptreact',
                'json',
                'jsonc',
                'markdown',
                'mdx',
                'typescript',
                'typescriptreact',
                'yaml',
            },
        }),
        formatting.shfmt.with({ extra_args = { '-i', '2' } }),
        formatting.sql_formatter,
        formatting.stylua,
    },
    on_attach = on_attach,
    debounce = 0,
})
