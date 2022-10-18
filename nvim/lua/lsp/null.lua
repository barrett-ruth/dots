local null_ls = require 'null-ls'
local builtins = null_ls.builtins
local on_attach = require('lsp.utils').on_attach

local projects = require 'projects'

local mypy_warnings = {
    'Need type annotation for',
    'Cannot find implementation or library stub',
}

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
            condition = function(_)
                local project = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')

                if projects[project] then
                    return vim.tbl_contains(
                        projects[project].null_ls.enabled,
                        'flake8'
                    )
                end

                return true
            end,
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
            diagnostics_postprocess = function(diagnostic)
                for _, mypy_warning in ipairs(mypy_warnings) do
                    if diagnostic.message:find(mypy_warning) then
                        diagnostic.severity = vim.diagnostic.severity.WARN
                    end
                end
            end,
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
        builtins.formatting.autopep8.with {
            condition = function(_)
                local project = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')

                if projects[project] then
                    return vim.tbl_contains(
                        projects[project].null_ls.enabled,
                        'autopep8'
                    )
                end

                -- Use black otherwise
                return false
            end,
        },
        builtins.formatting.black.with {
            condition = function(_)
                local project = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')

                if projects[project] then
                    return vim.tbl_contains(
                        projects[project].null_ls.enabled,
                        'black'
                    )
                end

                return true
            end,
            extra_args = { '-S', '--fast', '--line-length=79' },
        },
        builtins.formatting.isort.with {
            condition = function(_)
                local project = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')

                if projects[project] then
                    return vim.tbl_contains(
                        projects[project].null_ls.enabled,
                        'isort'
                    )
                end

                return true
            end,
        },

        builtins.formatting.clang_format.with {
            filetypes = { 'c', 'cpp' },
        },
        builtins.formatting.google_java_format,
        builtins.formatting.prettierd.with {
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
        builtins.formatting.shfmt.with {
            extra_args = { '-i', '4', '-ln=posix' },
        },
        builtins.formatting.sql_formatter,
        builtins.formatting.stylua.with {
            extra_args = {
                '--config-path',
                vim.env.XDG_CONFIG_HOME .. '/templates/stylua.toml',
            },
        },
        -- :]
    },
    diagnostics_format = '#{m} [#{c}] (#{s})',
    diagnostic_config = {
        signs = false,
        severity_sort = true,
        update_in_insert = false,
        virtual_text = false,
    },
    on_attach = on_attach,
    debounce = 0,
}
