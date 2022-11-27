return {
    standalone = false,
    on_attach = function(client, _)
        require('lsp.utils').on_attach(client, _)

        bmap { 'n', '\\Aa', '<cmd>RustCodeAction<cr>' }
        bmap { 'n', '\\Ae', '<cmd>RustExpand<cr>' }
        bmap { 'n', '\\Am', '<cmd>RustExpandMacro<cr>' }
    end,
}
