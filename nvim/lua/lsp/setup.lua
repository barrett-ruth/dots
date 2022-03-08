local M = {}

local on_attach = function(client)
    local lspleader = vim.g.mapleader .. vim.g.mapleader
    local utils = require 'utils'
    local map = utils.map
    local mapstr = utils.mapstr

    if client.name == 'tsserver' then
        local ts_utils = require 'nvim-lsp-ts-utils'

        ts_utils.setup {
            enable_import_on_completion = true,
            update_imports_on_move = true,
        }

        ts_utils.setup_client(client)

        map { 'n', lspleader .. 'ti', mapstr 'TSLspOrganize' }
        map { 'n', lspleader .. 'tr', mapstr 'TSLspRenameFile' }
        map { 'n', lspleader .. 'to', mapstr 'TSLspOrganize' }
    end

    map { 'n', ']<space>', mapstr 'lua vim.diagnostic.goto_next()' }
    map { 'n', '[<space>', mapstr 'lua vim.diagnostic.goto_prev()' }

    map { 'n', lspleader .. 'c', mapstr 'lua vim.lsp.buf.code_action()' }
    map { 'n', lspleader .. 'd', mapstr 'lua vim.lsp.buf.definition()' }
    map { 'n', lspleader .. 'D', mapstr 'lua vim.lsp.buf.declaration()' }
    map { 'n', lspleader .. 'f', mapstr 'lua vim.diagnostic.open_float()' }
    map { 'n', lspleader .. 'h', mapstr 'lua vim.lsp.buf.hover()' }
    map { 'n', lspleader .. 'i', mapstr 'lua vim.lsp.buf.implementation()' }
    map { 'n', lspleader .. 'r', mapstr 'lua vim.lsp.buf.rename()' }
    map { 'n', lspleader .. 'R', mapstr 'lua vim.lsp.buf.references()' }
    map { 'n', lspleader .. 's', mapstr 'lua vim.lsp.buf.signature_help()' }
    map { 'n', lspleader .. 'T', mapstr 'lua vim.lsp.buf.type_definition()' }
end

local lspconfig = require 'lspconfig'
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = false

local lsp_settings = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = { debounce_text_changes = 0 },
}

M.setup = function(server, ...)
    local settings = ...

    for k, v in pairs(lsp_settings) do
        settings[k] = v
    end

    lspconfig[server].setup(settings)
end

return M
