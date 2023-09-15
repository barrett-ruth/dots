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
        code_actions.gitrebase,
        code_actions.gitsigns,
        code_actions.shellcheck,

        diagnostics.curlylint.with({
            extra_filetypes = { 'html' },
        }),
        diagnostics.dotenv_linter.with({
            extra_args = {
                '--skip',
                'UnorderedKey',
                '--skip',
                'ValueWithoutQuotes',
            },
            filetypes = { 'config' },
            runtime_condition = function(_)
                return vim.fn.bufname():match('.*.env.*')
            end,
        }),
        diagnostics.gitlint.with({
            extra_args = { '--ignore', 'body-is-missing' },
        }),
        diagnostics.hadolint,
        diagnostics.markdownlint.with({
            diagnostics_format = '#{m}',
        }),
        diagnostics.mypy.with({
            extra_args = { '--check-untyped-defs' },
            runtime_condition = function(params)
                return require('null-ls.utils').path.exists(params.bufname)
            end,
        }),
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
        diagnostics.stylelint,
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
            extra_args = { '-S', '--fast', '--line-length=79' },
        }),
        formatting.cbfmt.with({
            condition = function(utils)
                return utils.root_has_file({ '.cbfmt.toml' })
            end,
        }),
        formatting.isort.with({
            condition = function(_)
                return project_contains_source('isort', true)
            end,
        }),
        formatting.djhtml.with({
            extra_args = { '--tabwidth', '2' },
        }),
        formatting.gofumpt,
        formatting.goimports_reviser,
        formatting.golines,
        formatting.latexindent,
        formatting.markdownlint,
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
                'markdown',
                'typescript',
                'typescriptreact',
                'yaml',
            },
        }),
        formatting.shfmt.with({
            extra_args = { '-i', '2' },
        }),
        formatting.sql_formatter,
        formatting.stylelint,
        formatting.stylua,
    },
    on_attach = on_attach,
    debounce = 0,
})
