return {
    on_attach = function(client, bufnr)
        require('lsp.utils').on_attach(client, bufnr)

        local utils = require 'utils'
        local bmap, mapstr = utils.bmap, utils.mapstr

        bmap { 'n', '\\Ca', mapstr 'ClangdAST' }
        bmap { 'n', '\\Cm', mapstr 'ClangdMemoryUsage' }
        bmap { 'n', '\\Cs', mapstr 'ClangdSwitchSourceHeader' }
        bmap { 'n', '\\Ct', mapstr 'ClangdToggleInlayHints' }
    end,
}
