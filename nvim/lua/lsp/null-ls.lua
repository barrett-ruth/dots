local on_attach = require('lsp.utils').on_attach
local projects = require('projects').projects

local null_ls = require('null-ls')
local builtins = null_ls.builtins
local code_actions, diagnostics, formatting =
    builtins.code_actions, builtins.diagnostics, builtins.formatting

local function project_contains_source(name, default)
    local project = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')

    if projects[project] and projects[project].lsp_sources then
        return vim.tbl_contains(projects[project].lsp_sources, name)
    end

    return default or false
end

null_ls.setup({
    sources = {
        code_actions.eslint_d,
        code_actions.gitrebase,
        code_actions.shellcheck,

        diagnostics.curlylint.with({
            extra_filetypes = { 'html' },
        }),
        diagnostics.eslint_d.with({
            condition = function(utils)
                return utils.root_has_file({
                    {
                        '.eslintrc',
                        '.eslintrc.cjs',
                        '.eslintrc.yaml',
                        '.eslintrc.yml',
                        '.eslintrc.json',
                    },
                })
            end,
        }),
        diagnostics.flake8.with({
            condition = function(_)
                return project_contains_source('flake8', true)
            end,
            diagnostics_postprocess = function(diagnostic)
                if diagnostic.severity == vim.diagnostic.severity.ERROR then
                    diagnostic.severity = vim.diagnostic.severity.WARN
                end
            end,
        }),
        diagnostics.dotenv_linter,
        diagnostics.hadolint,
        diagnostics.markdownlint.with({
            diagnostics_format = '#{m}',
        }),
        diagnostics.mypy,
        diagnostics.selene,
        diagnostics.shellcheck.with({
            runtime_condition = function(_)
                return not vim.fn.bufname():match('.env.*')
            end,
        }),
        diagnostics.sqlfluff.with({
            extra_args = {
                '--dialect',
                'postgres',
                '--exclude-rules',
                'LT02,LT05',
            },
        }),
        diagnostics.tsc,
        diagnostics.yamllint,

        formatting.autopep8.with({
            condition = function(_)
                return project_contains_source('autopep8', false)
            end,
        }),
        formatting.black.with({
            condition = function(_)
                return project_contains_source('black', true)
            end,
            extra_args = {
                '--skip-string-normalization',
                '--fast',
                '--line-length=79',
            },
        }),
        formatting.cbfmt,
        formatting.isort.with({
            condition = function(_)
                return project_contains_source('isort', true)
            end,
        }),

        formatting.clang_format.with({
            filetypes = { 'c', 'cpp' },
        }),
        formatting.djhtml.with({
            extra_args = { '--tabwidth', '2' },
        }),
        formatting.prettierd.with({
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
        }),
        formatting.shfmt.with({
            extra_args = { '-i', '4', '-ln=posix' },
        }),
        formatting.sql_formatter,
        formatting.stylua,
    },
    on_attach = on_attach,
    debounce = 0,
})
