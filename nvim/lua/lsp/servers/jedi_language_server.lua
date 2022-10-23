return {
    on_attach = function(client, bufnr)
        -- Disable providers meant for pyright
        for _, v in ipairs {
            'declaration',
            'definition',
            'documentSymbol',
            'typeDefinition',
            'workspaceSymbol',
        } do
            client.server_capabilities[v .. 'Provider'] = false
        end

        require('lsp.utils').on_attach(client, bufnr)
    end,
}
