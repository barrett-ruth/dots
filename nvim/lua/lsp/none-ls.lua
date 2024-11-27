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

        diagnostics.buf,
        diagnostics.checkmake,
        diagnostics.cmake_lint,
        require('none-ls.diagnostics.cpplint').with({
            extra_args = {
                '--filter',
                '-legal/copyright',
                '-whitespace/indent',
            },
            prepend_extra_args = true,
        }),
        require('none-ls.diagnostics.eslint_d'),
        diagnostics.hadolint,
        diagnostics.mypy.with({
            extra_args = { '--check-untyped-defs' },
            runtime_condition = function(params)
                return require('null-ls.utils').path.exists(params.bufname)
            end,
        }),
        diagnostics.selene,
        diagnostics.zsh,

        formatting.buf,
        formatting.cbfmt,
        formatting.cmake_format,
        require('none-ls.formatting.eslint_d'),
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
        formatting.stylua.with({
            condition = function(utils)
                return utils.root_has_file({ 'stylua.toml', '.stylua.toml' })
            end,
        }),

        hover.dictionary,
        hover.printenv,
    },
    on_attach = on_attach,
    debounce = 0,
})
