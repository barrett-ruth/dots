local fn = vim.fn

local null_ls = require 'null-ls'
local builtins = null_ls.builtins
local code_actions, diagnostics, formatting =
    builtins.code_actions, builtins.diagnostics, builtins.formatting
local on_attach = require('lsp.utils').on_attach

local projects = require 'projects'

local mypy_warnings = {
    'Need type annotation for',
    'Cannot find implementation or library stub',
}

null_ls.setup {
    sources = {
        -- Code Actions [:
        code_actions.eslint_d,
        code_actions.gitrebase,
        code_actions.shellcheck,
        -- :]

        -- Diagnostics [:
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
            condition = function(_)
                local project = fn.fnamemodify(fn.getcwd(), ':t')

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
        },
        diagnostics.hadolint,
        diagnostics.markdownlint.with {
            diagnostics_format = '#{m}',
        },
        diagnostics.mypy.with {
            diagnostics_postprocess = function(diagnostic)
                for _, mypy_warning in ipairs(mypy_warnings) do
                    if diagnostic.message:find(mypy_warning) then
                        diagnostic.severity = vim.diagnostic.severity.WARN
                    end
                end
            end,
        },
        diagnostics.shellcheck,
        diagnostics.tsc,
        diagnostics.yamllint,
        -- :]

        -- Formatting [:
        formatting.autopep8.with {
            condition = function(_)
                local project = fn.fnamemodify(fn.getcwd(), ':t')

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
        formatting.black.with {
            condition = function(_)
                local project = fn.fnamemodify(fn.getcwd(), ':t')

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
        formatting.isort.with {
            condition = function(_)
                local project = fn.fnamemodify(fn.getcwd(), ':t')

                if projects[project] then
                    return vim.tbl_contains(
                        projects[project].null_ls.enabled,
                        'isort'
                    )
                end

                return true
            end,
        },

        formatting.clang_format.with {
            filetypes = { 'c', 'cpp' },
        },
        formatting.google_java_format,
        formatting.prettierd.with {
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
        formatting.stylua.with {
            extra_args = {
                '--config-path',
                vim.env.XDG_CONFIG_HOME .. '/templates/stylua.toml',
            },
        },
        -- :]
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
