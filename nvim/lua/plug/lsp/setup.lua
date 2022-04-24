local M = {}

M.on_attach = function(client, bufnr)
    require('aerial').on_attach(client, bufnr)

    local utils = require 'utils'
    local bmap = utils.bmap
    local mapstr = utils.mapstr

    if client.name == 'tsserver' then
        local ts_utils = require 'nvim-lsp-ts-utils'

        ts_utils.setup {
            enable_import_on_completion = true,
            update_imports_on_move = true,
        }

        ts_utils.setup_client(client)
        bmap { 'n', '<leader><leader>ti', mapstr 'TSLspImportAll' }
        bmap { 'n', '<leader><leader>to', mapstr 'TSLspOrganize' }

        client.resolved_capabilities.document_formatting = false
    elseif client.name == 'clangd' then
        bmap { 'n', '<leader><leader>H', mapstr 'ClangdSwitchSourceHeader' }
    elseif client.name == 'sumneko_lua' or client.name == 'jsonls' then
        client.resolved_capabilities.document_formatting = false
    end

    bmap { 'n', ']<space>', mapstr 'lua vim.diagnostic.goto_next()' .. 'zz' }
    bmap { 'n', '[<space>', mapstr 'lua vim.diagnostic.goto_prev()' .. 'zz' }

    bmap { 'n', '<leader><leader>c', mapstr('telescope.builtin', 'lsp_code_actions()') }
    bmap { 'n', '<leader><leader>d', mapstr('telescope.builtin', 'lsp_definitions()') }
    bmap { 'n', '<leader><leader>I', mapstr('telescope.builtin', 'lsp_implementations()') }

    bmap { 'n', '<leader><leader>D', mapstr 'lua vim.lsp.buf.declaration()' }
    bmap { 'n', '<leader><leader>f', mapstr 'lua vim.diagnostic.open_float()' }
    bmap { 'n', '<leader><leader>h', mapstr 'lua vim.lsp.buf.hover()' }
    bmap { 'n', '<leader><leader>R', mapstr 'lua vim.lsp.buf.references()' }
    bmap { 'n', '<leader><leader>s', mapstr 'lua vim.lsp.buf.signature_help()' }

    bmap { 'n', '<leader><leader>li', mapstr 'LspInfo' }
    bmap { 'n', '<leader><leader>lI', mapstr 'NullLsInfo' }
    bmap { 'n', '<leader><leader>lr', mapstr 'LspRestart' }

    bmap { 'n', '<leader><leader>r', '<esc>' .. mapstr('plug.refactor', "setup_win('rename')") }
    bmap { 'v', '<leader>e', '<esc>' .. mapstr('plug.refactor', "setup_win('extract')") }
    bmap { 'v', '<leader>i', '<esc>' .. mapstr('plug.refactor', 'inline()') }
    bmap { 'v', '<leader>p', '<esc>' .. mapstr('plug.refactor', 'print()') }
    bmap { 'v', '<leader>P', '<esc>' .. mapstr('plug.refactor', 'print(true)') }
end

local lspconfig = require 'lspconfig'

M.setup = function(server, ...)
    local settings = ...

    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.textDocument.completion.completionItem.snippetSupport = false
    capabilities.offsetEncoding = { 'utf-16' }

    settings.capabilities = capabilities
    settings.on_attach = M.on_attach
    settings.flags = { debounce_text_changes = 0 }

    lspconfig[server].setup(settings)
end

return M
