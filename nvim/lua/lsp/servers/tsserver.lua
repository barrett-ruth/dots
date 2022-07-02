return {
    on_attach = function(client, bufnr)
        require('lsp.utils').on_attach(client, bufnr)

        local utils = require 'utils'
        local bmap, mapstr = utils.bmap, utils.mapstr

        local ts_utils = require 'nvim-lsp-ts-utils'

        ts_utils.setup {
            auto_inlay_hints = false,
            enable_import_on_completion = true,
            update_imports_on_move = true,
        }

        ts_utils.setup_client(client)

        bmap { 'n', '\\Ti', mapstr 'TSLspImportAll' }
        bmap { 'n', '\\To', mapstr 'TSLspOrganize' }
    end,
    init_options = require('nvim-lsp-ts-utils').init_options,
}
