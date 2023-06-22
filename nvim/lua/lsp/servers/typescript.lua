return {
    settings = {
        typescript = {
            inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
        },
        javascript = {
            inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
        },
    },
    on_attach = function()
        bmap({ 'n', '\\Tf', '<cmd>TypescriptFixAll<cr>' })
        bmap({ 'n', '\\Ti', '<cmd>TypescriptAddMissingImports<cr>' })
        bmap({ 'n', '\\To', '<cmd>TypescriptOrganizeImports<cr>' })
        bmap({ 'n', '\\Tr', '<cmd>TypescriptRenameFile<cr>' })
        bmap({ 'n', '\\Tu', '<cmd>TypescriptRemoveUnused<cr>' })
    end,
}
