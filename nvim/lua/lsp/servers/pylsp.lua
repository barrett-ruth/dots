return {
    settings = {
        format = false,
    },
    on_attach = function(client, bufnr)
        client.sever_capabilities.completionProvider = false
        client.server_capabilities.documentSymbolProvider = false
        client.server_capabilities.renameProvider = false
        client.server_capabilities.workspaceSymbolProvider = false

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
