return {
    on_attach = function(client, bufnr)
        -- Disable providers meant for pyright
        for _, provider in ipairs {
            'declaration',
            'definition',
            'documentSymbol',
            'typeDefinition',
            'workspaceSymbol',
        } do
            client.server_capabilities[provider .. 'Provider'] = false
        end

        require('lsp.utils').on_attach(client, bufnr)
    end,
}
