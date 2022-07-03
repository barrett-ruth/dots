return {
    on_attach = function(client, bufnr)
        require('lsp.utils').on_attach(client, bufnr)

        local utils = require 'utils'
        local bmap, mapstr = utils.bmap, utils.mapstr

        bmap { 'n', '\\Tf', mapstr 'TypescriptFixAll' }
        bmap { 'n', '\\Ti', mapstr 'TypescriptAddMissingImports' }
        bmap { 'n', '\\To', mapstr 'TypescriptOrganizeImports' }
        bmap { 'n', '\\Tr', mapstr 'TypescriptRenameFile' }
        bmap { 'n', '\\Tu', mapstr 'TypescriptRemoveUnused' }
    end,
}
