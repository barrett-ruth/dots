local lsp = vim.lsp

return {
    on_attach = function(_, bufnr)
        bmap({
            'n',
            '\\ti',
            function()
                vim.cmd.TSToolsAddMissingImports()
                vim.cmd.TSToolsOrganizeImports()
            end,
        }, { buffer = bufnr })
        bmap({ 'n', '\\tf', vim.cmd.TSToolsFixAll }, { buffer = bufnr })
        bmap(
            { 'n', 'gD', vim.cmd.TSToolsGoToSourceDefinition },
            { buffer = bufnr }
        )
    end,
    settings = {
        complete_function_calls = true,
        expose_as_code_action = 'all',
        tsserver_file_preferences = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
        },
    },
    handlers = {
        [lsp.protocol.Methods.textDocument_publishDiagnostics] = function(
            _,
            result,
            ctx,
            config
        )
            local ok, format_ts = pcall(require, 'format-ts-errors')
            local filtered = {}

            for _, diagnostic in ipairs(result.diagnostics) do
                if
                    not vim.tbl_contains({
                        80001, -- "File is a CommonJS module; it may be converted to an ES module."
                        80006, -- "This may be converted to an async function."
                    }, diagnostic.code)
                then
                    if ok then
                        local formatter = format_ts[diagnostic.code]
                        diagnostic.message = formatter
                                and formatter(diagnostic.message)
                            or diagnostic.message
                    end

                    filtered[#filtered + 1] = diagnostic
                end
            end

            result.diagnostics = filtered
            lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
        end,
    },
}
