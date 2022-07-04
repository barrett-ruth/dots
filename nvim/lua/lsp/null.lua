local null_ls = require 'null-ls'
local builtins = null_ls.builtins
local on_attach = require('lsp.utils').on_attach

null_ls.setup {
    sources = {
        -- Diagnostics [:
        builtins.diagnostics.curlylint.with {
            diagnostics_format = '#{m}',
            extra_filetypes = { 'html' },
        },
        builtins.diagnostics.eslint_d.with {
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
            diagnostics_format = '#{m} (#{s})',
        },
        builtins.diagnostics.flake8.with {
            diagnostics_postprocess = function(diagnostic)
                if diagnostic.severity == vim.diagnostic.severity.ERROR then
                    diagnostic.severity = vim.diagnostic.severity.WARN
                end
            end,
            diagnostics_format = '#{m}',
        },
        builtins.diagnostics.hadolint.with {
            diagnostics_format = '#{m}',
        },
        builtins.diagnostics.mypy.with {
            diagnostics_format = '#{m}',
        },
        builtins.diagnostics.shellcheck.with {
            diagnostics_format = '#{m}',
        },
        builtins.diagnostics.tsc,
        builtins.diagnostics.yamllint.with {
            diagnostics_format = '#{m}',
        },
        -- :]

        -- Formatting [:
        builtins.formatting.black.with {
            extra_args = { '-S', '--fast', '--line-length=79' },
        },
        builtins.formatting.clang_format,
        builtins.formatting.isort,
        builtins.formatting.prettierd,
        builtins.formatting.shfmt.with {
            extra_args = { '-i', '4', '-ln=posix' },
        },
        builtins.formatting.stylua.with {
            extra_args = {
                '--config-path',
                vim.fn.expand '~/.config/templates/stylua.toml',
            },
        },
        -- :]
    },
    update_in_insert = false,
    diagnostics_format = '#{m} [#{c}] (#{s})',
    on_attach = on_attach,
    debounce = 0,
}
