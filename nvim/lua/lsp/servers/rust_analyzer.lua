return {
    standalone = false,
    settings = {
        ['rust-analyzer'] = {
            checkOnSave = {
                overrideCommand = {
                    'cargo',
                    'clippy',
                    '--message-format=json',
                    '--',
                    '-W', 'clippy::expect_used',
                    '-W', 'clippy::nursery',
                    '-W', 'clippy::pedantic',
                    '-W', 'clippy::unwrap_used',
                },
            },
        },
    },
    on_attach = function(client, _)
        require('lsp.utils').on_attach(client, _)

        bmap { 'n', '\\Aa', '<cmd>RustCodeAction<cr>' }
        bmap { 'n', '\\Ae', '<cmd>RustExpand<cr>' }
        bmap { 'n', '\\Am', '<cmd>RustExpandMacro<cr>' }
    end,
}
