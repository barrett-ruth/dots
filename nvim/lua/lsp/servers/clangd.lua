return {
    on_attach = function(client, bufnr)
        require('lsp.utils').on_attach(client, bufnr)

        local utils = require 'utils'
        utils.bmap { 'n', '\\H', utils.mapstr 'ClangdSwitchSourceHeader' }
    end,
}
