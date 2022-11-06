return {
    on_attach = function(client, bufnr)
        require('lsp.utils').on_attach(client, bufnr)

        bmap { 'n', '\\Tf', '<cmd>TypescriptFixAll<cr>' }
        bmap { 'n', '\\Ti', '<cmd>TypescriptAddMissingImports<cr>' }
        bmap { 'n', '\\To', '<cmd>TypescriptOrganizeImports<cr>' }
        bmap { 'n', '\\Tr', '<cmd>TypescriptRenameFile<cr>' }
        bmap { 'n', '\\Tu', '<cmd>TypescriptRemoveUnused<cr>' }
    end,
}
