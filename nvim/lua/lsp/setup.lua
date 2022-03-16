local M = {}

local on_attach = function(client, bufnr)
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

        bmap { 'n', '<leader><leader>ti', mapstr 'TSLspOrganize' }
        bmap { 'n', '<leader><leader>td', mapstr('telescope.builtin', 'lsp_type_definitions') }
        bmap { 'n', '<leader><leader>tr', mapstr 'TSLspRenameFile' }
        bmap { 'n', '<leader><leader>to', mapstr 'TSLspOrganize' }
    elseif client.name == 'clangd' then
        bmap { 'n', '<leader><leader>H', mapstr 'ClangdSwitchSourceHeader' }
    end

    bmap { 'n', ']<space>', mapstr 'lua vim.diagnostic.goto_next()' .. 'zz' }
    bmap { 'n', '[<space>', mapstr 'lua vim.diagnostic.goto_prev()' .. 'zz' }

    bmap { 'n', '<leader><leader>c', mapstr('telescope.builtin', 'lsp_code_actions()') }
    bmap { 'n', '<leader><leader>d', mapstr('telescope.builtin', 'lsp_definitions()') }
    bmap { 'n', '<leader><leader>i', mapstr('telescope.builtin', 'lsp_implementations()') }
    bmap { 'n', '<leader><leader>R', mapstr('telescope.builtin', 'lsp_references()') }

    bmap { 'n', '<leader><leader>D', mapstr 'lua vim.lsp.buf.declaration()' }
    bmap { 'n', '<leader><leader>f', mapstr 'lua vim.diagnostic.open_float()' }
    bmap { 'n', '<leader><leader>h', mapstr 'lua vim.lsp.buf.hover()' }
    bmap { 'n', '<leader><leader>r', mapstr 'lua vim.lsp.buf.rename()' }
    bmap { 'n', '<leader><leader>s', mapstr 'lua vim.lsp.buf.signature_help()' }
    bmap { 'n', '<leader><leader>T', mapstr 'lua vim.lsp.buf.type_definition()' }
end

local lspconfig = require 'lspconfig'

M.setup = function(server, ...)
    local settings = ...

    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.textDocument.completion.completionItem.snippetSupport = false

    settings.capabilities = capabilities
    settings.on_attach = on_attach
    settings.flags = { debounce_text_changes = 0 }

    lspconfig[server].setup(settings)
end

return M
