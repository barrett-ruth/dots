return {
    capabilities = {
        workspace = {
            configuration = true,
        },
    },
    on_attach = function(client, bufnr)
        require('jdtls').setup.add_commands()

        local utils = require 'utils'
        local bmap, mapstr = utils.bmap, utils.mapstr

        bmap { 'n', '\\jb', mapstr 'JdtBytecode' }
        bmap { 'n', '\\jo', mapstr('jdtls', 'organize_imports()') }
        bmap { 'n', '\\jr', mapstr 'JdtRestart' }

        require('lsp.utils').on_attach(client, bufnr)
    end,
}
