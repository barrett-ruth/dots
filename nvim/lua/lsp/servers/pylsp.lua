return {
    settings = {
        format = false,
    },
    on_attach = function(client, bufnr)
        -- Disable providers meant for pyright
        for _, provider in ipairs({
            'completion',
            'documentSymbol',
            -- 'hover', -- unsure if pylsp's or pyright's hoverProvider is better
            'rename',
            'workspaceSymbol',
        }) do
            client.server_capabilities[provider .. 'Provider'] = false
        end

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
