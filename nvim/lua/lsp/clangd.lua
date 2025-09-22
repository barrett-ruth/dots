local config = require('projects')

local clangd_settings = {
    filetypes = { 'c', 'cpp' },
    cmd = {
        'clangd',
        '--clang-tidy',
        '-j=4',
        '--background-index',
        '--completion-style=bundled',
        '--header-insertion=iwyu',
        '--header-insertion-decorators=false',
    },
}

local project_settings = (config.lsp and config.lsp.clangd)
    and config.lsp.clangd

require('utils').au('LspAttach', 'ClangdKeymap', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == 'clangd' then
            bmap({ 'n', 'gh', vim.cmd.ClangdSwitchSourceHeader }, { buffer = args.buf })
        end
    end,
})

return vim.tbl_extend('force', clangd_settings, project_settings or {})
