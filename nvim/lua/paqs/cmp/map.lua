local utils = require 'utils'
local cmp = require 'cmp'
utils.map {
    { 'i', 'n' },
    '<c-space>',
    function()
        CMP_ENABLED = (CMP_ENABLED == nil) and true or not CMP_ENABLED
        if CMP_ENABLED then
            cmp.setup.buffer { enabled = true }
            cmp.complete()
        else
            cmp.setup.buffer { enabled = false }
            cmp.close()
        end
    end,
}

utils.map { 'i', '<c-n>', utils.mapstr('cmp', 'select_next_item()') }
utils.map { 'i', '<c-p>', utils.mapstr('cmp', 'select_prev_item()') }
utils.map { 'i', '<c-y>', utils.mapstr('cmp', 'confirm { select = true }') }
utils.map { 'i', '<c-b>', utils.mapstr('cmp', 'scroll_docs(-4)') }
utils.map { 'i', '<c-f>', utils.mapstr('cmp', 'scroll_docs(4)') }
utils.map { 'i', '<c-e>', utils.mapstr('cmp', 'abort()') }
