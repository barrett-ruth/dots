local M = {}

function M.empty(s)
    return s == '' or s == nil
end

function M.toggle_list(prefix)
    if prefix == 'c' then
        QFL = (next(vim.fn.getqflist()) == nil) and false or not QFL
    else
        LL = (next(vim.fn.getloclist(0)) == nil) and false or not LL
    end

    local cmd = (prefix == 'c' and QFL or LL) and 'ope' or 'cl'

    vim.cmd(prefix .. cmd)
end

local cmp_active = false
function M.toggle_cmp()
    cmp_active = not cmp_active

    local cmp = require 'cmp'
    cmp.setup.buffer { enabled = cmp_active }

    if cmp_active then
        cmp.close()
    else
        cmp.complete()
    end
end

local diagnostics_active = false
function M.toggle_diagnostics()
    diagnostics_active = not diagnostics_active
    if diagnostics_active then
        vim.diagnostic.hide()
    else
        vim.diagnostic.show(nil, 0)
    end
end

function M.map(mapping)
    vim.keymap.set(mapping[1], mapping[2], mapping[3], { noremap = true, silent = true })
end

function M.bmap(mapping)
    vim.keymap.set(mapping[1], mapping[2], mapping[3], { noremap = true, silent = true, buffer = vim.fn.bufnr '%' })
end

function M.mapstr(req, meth)
    return M.empty(meth) and string.format('<cmd>%s<cr>', req)
        or string.format("<cmd>lua require '%s'.%s<cr>", req, meth)
end

return M
