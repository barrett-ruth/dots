return {
    capabilities = {
        workspace = {
            configuration = true,
        },
    },
    on_attach = function(client, bufnr)
        local jdtls = require 'jdtls'
        jdtls.setup.add_commands()

        -- TODO: extract to lua functions
        bmap { 'n', '\\jb', '<cmd>JdtBytecode<cr>' }
        bmap { 'n', '\\jc', jdtls.extract_constant }
        bmap { 'n', '\\je', jdtls.extract_variable }
        bmap { 'n', '\\jl', '<cmd>JdtShowLogs<cr>' }
        bmap {
            'v',
            '\\jm',
            function()
                jdtls.extract_method(true)
            end,
        }
        bmap { 'n', '\\jo', jdtls.organize_imports }
        bmap { 'n', '\\jr', '<cmd>JdtRestart<cr>' }

        require('lsp.utils').on_attach(client, bufnr)
    end,
}
