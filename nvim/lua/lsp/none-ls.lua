local on_attach = require('lsp.utils').on_attach

local null_ls = require('null-ls')
local builtins = null_ls.builtins
local code_actions, diagnostics, formatting, hover =
    builtins.code_actions,
    builtins.diagnostics,
    builtins.formatting,
    builtins.hover

null_ls.setup({
    sources = {
        require('none-ls.code_actions.eslint_d'),
        code_actions.gitrebase,
        code_actions.gitsigns,
        code_actions.proselint,

        diagnostics.buf,
        diagnostics.checkmake,
        diagnostics.cmake_lint,
        require('none-ls.diagnostics.cpplint').with({
            extra_args = { '--filter', '-legal/copyright', '-whitespace/indent' },
            prepend_extra_args = true,
        }),
        diagnostics.djlint,
        diagnostics.dotenv_linter,
        require('none-ls.diagnostics.eslint_d'),
        diagnostics.gitlint.with({
            extra_args = { '--ignore', 'body-is-missing' },
        }),
        diagnostics.hadolint,
        diagnostics.markdownlint_cli2.with({
            extra_args = { '--disable', 'MD033', 'MD013' },
        }),
        diagnostics.mypy.with({
            extra_args = { '--check-untyped-defs' },
            runtime_condition = function(params)
                return require('null-ls.utils').path.exists(params.bufname)
            end,
        }),
        diagnostics.npm_groovy_lint,
        diagnostics.proselint,
        diagnostics.selene,
        diagnostics.sqlfluff.with({
            extra_args = {
                '--dialect',
                'postgres',
                '--exclude-rules',
                'LT02,LT05', -- indent, line length
            },
        }),
        diagnostics.staticcheck,
        diagnostics.write_good,
        diagnostics.yamllint,
        diagnostics.zsh,

        formatting.asmfmt,
        formatting.blackd.with({ extra_args = { '--fast' } }),
        formatting.buf,
        formatting.cbfmt.with({
            condition = function(utils)
                return utils.root_has_file({ '.cbfmt.toml' })
            end,
        }),
        formatting.cmake_format,
        require('none-ls.formatting.eslint_d'),
        formatting.google_java_format,
        formatting.gofumpt,
        formatting.goimports,
        formatting.goimports_reviser,
        formatting.golines,
        formatting.isort.with({ extra_args = { '--profile', 'black' } }),
        formatting.npm_groovy_lint,
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
        formatting.yamlfmt,

        hover.dictionary,
        hover.printenv,
    },
    on_attach = on_attach,
    debounce = 0,
})
