local lsp = vim.lsp

return {
    on_attach = function(_, bufnr)
        bmap(
            { 'n', 'gD', vim.cmd.TSToolsGoToSourceDefinition },
            { buffer = bufnr }
        )
    end,
    settings = {
        expose_as_code_action = 'all',
        tsserver_path = vim.env.XDG_DATA_HOME
            .. '/pnpm/global/5/node_modules/typescript/lib/tsserver.js',
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
    -- https://github.com/davidosomething/format-ts-errors.nvim
    handlers = {
        ['textDocument/publishDiagnostics'] = function(_, result, ctx, config)
            if not result.diagnostics then
                return
            end

            local ok, format_ts = pcall(require, 'format-ts-errors')
            if not ok then
                return
            end

            local idx = 1
            while idx <= #result.diagnostics do
                local diagnostic = result.diagnostics[idx]

                if
                    vim.tbl_contains({
                        80001, -- "File is a CommonJS module; it may be converted to an ES module."
                        80006, -- "This may be converted to an async function."
                    }, diagnostic.code)
                then
                    table.remove(result.diagnostics, idx)
                else
                    if ok then
                        local formatter = format_ts[diagnostic.code]
                        diagnostic.message = formatter
                                and formatter(diagnostic.message)
                            or diagnostic.message
                    end

                    idx = idx + 1
                end
            end

            lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
        end,
    },
}
