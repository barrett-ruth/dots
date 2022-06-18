local M = {}

function _G.pr(...)
    vim.pretty_print(...)
end

function M.empty(s)
    return s == '' or s == nil
end

function M.rfind(str, char)
    local revpos = str:reverse():find(char)

    if revpos == nil then
        return nil
    end

    return #str - revpos
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

M.bmap = function(mapping, opts)
    opts = opts or {}
    opts.buffer = 0
    M.map(mapping, opts)
end

function M.mapstr(req, meth)
    return M.empty(meth) and string.format('<cmd>%s<cr>', req)
        or string.format([[<cmd>lua require '%s'.%s<cr>]], req, meth)
end

return M
