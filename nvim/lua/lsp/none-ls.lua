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

        diagnostics.hadolint,
        diagnostics.markdownlint,
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

        formatting.black.with({
            condition = function(_)
                return project_contains_source('black', true)
            end,
            extra_args = { '-S', '--fast', '--line-length', '80' },
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
            extra_args = { '--profile', 'black', '--line-length', '80' },
        }),
        formatting.djhtml.with({ extra_args = { '--tabwidth', '2' } }),
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
