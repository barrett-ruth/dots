return {
    on_attach = function(client, bufnr)
        -- Disable providers meant for jedi_language_server
        for _, provider in ipairs { 'hover', 'completion' } do
            client.server_capabilities[provider .. 'Provider'] = false
        end

        require('lsp.utils').on_attach(client, bufnr)
    end,
}
