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
                    '-W',
                    'clippy::expect_used',
                    '-W',
                    'clippy::pedantic',
                    '-W',
                    'clippy::unwrap_used',
                },
            },
        },
    },
    on_attach = function()
        bmap({ 'n', '\\Rc', '<cmd>RustLsp codeAction<cr>' })
        bmap({ 'n', '\\Rm', '<cmd>RustLsp expandMacro<cr>' })
        bmap({ 'n', '\\Ro', '<cmd>RustLsp openCargo<cr>' })
    end,
}
