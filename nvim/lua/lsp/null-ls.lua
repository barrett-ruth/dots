local on_attach = require('lsp.utils').on_attach

local null_ls = require 'null-ls'
local builtins = null_ls.builtins
local code_actions, diagnostics, formatting =
    builtins.code_actions, builtins.diagnostics, builtins.formatting

null_ls.setup {
    sources = {
        -- Code Actions
        code_actions.eslint_d,
        code_actions.gitrebase,
        code_actions.shellcheck,

        -- Diagnostics
        diagnostics.curlylint.with {
            extra_filetypes = { 'html' },
        },
        diagnostics.eslint_d.with {
            condition = function(utils)
                return utils.root_has_file {
                    {
                        '.eslintrc',
                        '.eslintrc.cjs',
                        '.eslintrc.yaml',
                        '.eslintrc.yml',
                        '.eslintrc.json',
                    },
                }
            end,
        },
        diagnostics.flake8.with {
            diagnostics_postprocess = function(diagnostic)
                if diagnostic.severity == vim.diagnostic.severity.ERROR then
                    diagnostic.severity = vim.diagnostic.severity.WARN
                end
            end,
        },
        diagnostics.hadolint,
        diagnostics.markdownlint.with {
            diagnostics_format = '#{m}',
        },
        diagnostics.mypy,
        diagnostics.shellcheck,
        diagnostics.tsc,
        diagnostics.yamllint,

        -- Formatting
        formatting.black.with {
            extra_args = {
                '--skip-string-normalization',
                '--fast',
                '--line-length=79',
            },
        },
        formatting.isort,

        formatting.clang_format.with {
            filetypes = { 'c', 'cpp' },
        },
        formatting.prettier.with {
            filetypes = {
                'css',
                'graphql',
                'html',
                'javascript',
                'javascriptreact',
                'json',
                'markdown',
                'typescript',
                'typescriptreact',
                'yaml',
            },
        },
        formatting.shfmt.with {
            extra_args = { '-i', '4', '-ln=posix' },
        },
        formatting.sql_formatter,
        formatting.stylua,
    },
    diagnostic_config = {
        signs = false,
        severity_sort = true,
        update_in_insert = false,
        virtual_text = false,
    },
    on_attach = on_attach,
    debounce = 0,
}
