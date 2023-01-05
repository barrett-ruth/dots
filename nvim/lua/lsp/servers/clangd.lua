return {
    on_attach = function(client, _)
        require('lsp.utils').on_attach(client, _)

        bmap { 'n', '\\h', '<cmd>ClangdSwitchSourceHeader<cr>' }
    end,
}
