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

            if ok then
                -- ignore some tsserver diagnostics
                local idx = 1
                while idx <= #result.diagnostics do
                    local entry = result.diagnostics[idx]

                    local formatter = format_ts[entry.code]
                    entry.message = formatter and formatter(entry.message)
                        or entry.message

                    -- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
                    if
                        vim.tbl_contains({
                            80001, -- "File is a CommonJS module; it may be converted to an ES module."
                            80006, -- "This may be converted to an async function."
                        }, entry.code)
                    then
                        table.remove(result.diagnostics, idx)
                    else
                        idx = idx + 1
                    end
                end
            end

            lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
        end,
    },
}
