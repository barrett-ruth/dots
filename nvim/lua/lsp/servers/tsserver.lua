local function organize_imports()
    local params = {
        command = '_typescript.organizeImports',
        arguments = {
            vim.api.nvim_buf_get_name(0),
        },
    }
    vim.print(vim.lsp.buf.execute_command(params))
end

return {
    init_options = {
        preferences = { disableSuggestions = true },
    },
    settings = {
        tsserver_file_preferences = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
        },
    },
    on_attach = function()
        vim.api.nvim_create_user_command(
            'OrganizeImports',
            organize_imports,
            { desc = 'Organize TypeScript Imports' }
        )
    end,
}
