local M = {}

local on_attach = function(client, bufnr)
    require('aerial').on_attach(client, bufnr)

    local lspleader = string.rep('<leader>', 2)
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

        bmap { 'n', lspleader .. 'ti', mapstr 'TSLspOrganize' }
        bmap { 'n', lspleader .. 'td', mapstr('telescope.builtin', 'lsp_type_definitions') }
        bmap { 'n', lspleader .. 'tr', mapstr 'TSLspRenameFile' }
        bmap { 'n', lspleader .. 'to', mapstr 'TSLspOrganize' }
    elseif client.name == 'clangd' then
        bmap { 'n', lspleader .. 'H', mapstr 'ClangdSwitchSourceHeader' }
    end

    bmap { 'n', ']<space>', mapstr 'lua vim.diagnostic.goto_next()' .. 'zz' }
    bmap { 'n', '[<space>', mapstr 'lua vim.diagnostic.goto_prev()' .. 'zz' }

    bmap { 'n', lspleader .. 'c', mapstr('telescope.builtin', 'lsp_code_actions()') }
    bmap { 'n', lspleader .. 'd', mapstr('telescope.builtin', 'lsp_definitions()') }
    bmap { 'n', lspleader .. 'i', mapstr('telescope.builtin', 'lsp_implementations()') }
    bmap { 'n', lspleader .. 'R', mapstr('telescope.builtin', 'lsp_references()') }

    bmap { 'n', lspleader .. 'D', mapstr 'lua vim.lsp.buf.declaration()' }
    bmap { 'n', lspleader .. 'f', mapstr 'lua vim.diagnostic.open_float()' }
    bmap { 'n', lspleader .. 'h', mapstr 'lua vim.lsp.buf.hover()' }
    bmap { 'n', lspleader .. 'r', mapstr 'lua vim.lsp.buf.rename()' }
    bmap { 'n', lspleader .. 's', mapstr 'lua vim.lsp.buf.signature_help()' }
    bmap { 'n', lspleader .. 'T', mapstr 'lua vim.lsp.buf.type_definition()' }
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
