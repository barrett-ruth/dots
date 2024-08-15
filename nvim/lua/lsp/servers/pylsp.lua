return {
    settings = {
        format = false,
    },
    on_attach = function(client, bufnr)
        bmap({
            'n',
            '<leader>ps',
            function()
                vim.fn.system({
                    'pip',
                    'install',
                    'black',
                    'isort',
                    'ruff',
                    'jedi',
                    'python-lsp-server',
                    'python-lsp-ruff',
                    'python-lsp-isort',
                    'python-lsp-black',
                    -- 'pyright',
                    'mypy',
                    'mypy-extensions',
                })
                vim.fn.system({ 'mypy', '--install-types' })
            end,
        }, { buffer = bufnr })

        bmap({
            'n',
            '<leader>pm',
            function()
                vim.fn.system({ 'mypy', '--install-types' })
            end,
        }, { buffer = bufnr })
    end,
}
