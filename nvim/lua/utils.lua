local M = {}

function M.empty(s)
    return s == '' or s == nil
end

function M.delete_buffer(wipe)
    local bufs = vim.fn.getbufinfo { buflisted = 1 }
    local winnr, bufnr = vim.fn.winnr(), vim.fn.bufnr()

    if #bufs < 2 then
        vim.cmd 'conf qa'
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

function M.leave_snippet()
    local ls = require 'luasnip'

    if
        ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
        and ls.session.current_nodes[vim.api.nvim_get_current_buf()]
        and not ls.session.jump_active
    then
        ls.unlink_current()
    end
end

function M.toggle_list(prefix)
    for _, buf in ipairs(vim.fn.getbufinfo { buflisted = 1 }) do
        if vim.api.nvim_buf_get_option(buf.bufnr, 'ft') == 'qf' then
            vim.cmd(prefix == 'c' and 'ccl' or 'lcl')
            return
        end
    end

    vim.cmd(prefix == 'c' and 'cope' or 'lop')
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

function M.bmap(mapping, opts)
    opts = opts or {}
    opts.buffer = vim.fn.bufnr '%'
    M.map(mapping, opts)
end

function M.mapstr(req, meth)
    return M.empty(meth) and string.format('<cmd>%s<cr>', req)
        or string.format("<cmd>lua require '%s'.%s<cr>", req, meth)
end

return M
