local on_attach = require('lsp.utils').on_attach

local null_ls, logger = require('null-ls'), require('null-ls.logger')
local builtins = null_ls.builtins
local code_actions, diagnostics, formatting, hover =
    builtins.code_actions,
    builtins.diagnostics,
    builtins.formatting,
    builtins.hover

local function check_formatter_exit_code(code, stderr)
    local success = code <= 0

    if not success then
        vim.schedule(function()
            logger:warn(('failed to run formatter: %s'):format(stderr))
        end)
    end

    return success
end

null_ls.setup({
    border = 'single',
    sources = {
        require('none-ls.code_actions.eslint_d'),
        code_actions.gitrebase,
        code_actions.gitsigns,

        diagnostics.buf,
        diagnostics.checkmake,
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

        formatting.buf.with({
            check_exit_code = check_formatter_exit_code,
        }),
        formatting.cbfmt.with({
            check_exit_code = check_formatter_exit_code,
        }),
        formatting.cmake_format.with({
            check_exit_code = check_formatter_exit_code,
        }),
        require('none-ls.formatting.eslint_d').with({

            check_exit_code = check_formatter_exit_code,
        }),
        formatting.prettierd.with({
            check_exit_code = check_formatter_exit_code,
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
        formatting.shfmt.with({
            extra_args = { '-i', '2' },
            check_exit_code = check_formatter_exit_code,
        }),
        formatting.stylua.with({
            condition = function(utils)
                return utils.root_has_file({ 'stylua.toml', '.stylua.toml' })
            end,
            -- check_exit_code = check_formatter_exit_code,
        }),

        hover.dictionary,
        hover.printenv,
    },
    on_attach = on_attach,
    debounce = 0,
})
