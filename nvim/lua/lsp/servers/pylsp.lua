return {
    on_attach = function(client, _)
        -- Disable providers meant for pyright
        for _, provider in ipairs({
            'completion',
            'documentSymbol',
            'hover', -- unsure if pylsp or pyrights' hoverProvider is better
            'rename',
            'workspaceSymbol',
        }) do
            client.server_capabilities[provider .. 'Provider'] = false
        end
    end,
}
