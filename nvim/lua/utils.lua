local M = {}

function M.empty(s)
    return s == '' or s == nil
end

function M.delete_buffer(wipe)
    local bufs = vim.fn.getbufinfo { buflisted = 1 }
    local winnr, bufnr = vim.fn.winnr(), vim.fn.bufnr()

    if #bufs < 2 then
        vim.cmd 'conf qall'
        return
    end

    local cur_bufs = vim.fn.win_findbuf(bufnr)

    for _, winid in ipairs(cur_bufs) do
        vim.cmd(string.format('%d winc w', vim.fn.win_id2win(winid)))
        vim.cmd(bufnr == bufs[#bufs].bufnr and 'bp' or 'bn')
    end

    vim.cmd(string.format('%d winc w', winnr))
    vim.cmd('sil! conf b' .. (wipe and 'w' or 'd') .. ' #')

    if vim.fn.len(vim.fn.win_findbuf(vim.fn.bufnr())) > 1 then
        vim.cmd 'q'
    end
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

function M.map(mapping, opts)
    local kopts = { noremap = true, silent = true }

    if opts then
        for k, v in pairs(opts) do
            kopts[k] = v
        end
    end

    vim.keymap.set(mapping[1], mapping[2], mapping[3], kopts)
end

function M.bmap(mapping)
    vim.keymap.set(mapping[1], mapping[2], mapping[3], {
        noremap = true,
        silent = true,
        buffer = vim.fn.bufnr '%',
    })
end

function M.mapstr(req, meth)
    return M.empty(meth) and string.format('<cmd>%s<cr>', req)
        or string.format("<cmd>lua require '%s'.%s<cr>", req, meth)
end

return M
