return {
    on_attach = function(client, _)
        client.server_capabilities.definitionProvider = false
        client.server_capabilities.referencesProvider = false

        vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
            function(_, result, ctx, config)
                local index = 1
                local size = #result.diagnostics

                for _, diagnostic in ipairs(result.diagnostics) do
                    if
                        not (diagnostic.message):match('"_.+" is not accessed')
                    then
                        result.diagnostics[index] = diagnostic
                        index = index + 1
                    end
                end

                for i = index, size do
                    result.diagnostics[i] = nil
                end

                vim.lsp.diagnostic.on_publish_diagnostics(
                    _,
                    result,
                    ctx,
                    config
                )
            end,
            {}
        )
    end,
    settings = {
        python = {
            analysis = {
                typeCheckingMode = 'off',
            },
        },
    },
}
