local M = {}

_G.pr = function(...)
    vim.pretty_print(...)
end

-- Colorscheme [:
M.cs = {
    bg = '#282828',
    black = '#5a524c',
    red = '#ea6962',
    green = '#a9b665',
    yellow = '#d8a657',
    blue = '#7daea3',
    purple = '#d3869b',
    cyan = '#89b482',
    white = '#d4be98',
    orange = '#e78a4e',
    grey = '#928374',
    light_grey = '#32302f',
    grey_white = '#45403d',
    hi = '#a89984',
}

M.hi = function(group, highlights)
    if highlights.none then
        highlights.none = nil
        highlights.undercurl = false
        highlights.italic = false
        highlights.bold = false
    end
    vim.api.nvim_set_hl(0, group, highlights)
end
-- :]

M.tempcd = function(cmd)
    vim.cmd 'cd %:h'
    vim.cmd(cmd)
    vim.cmd 'cd -'
end

M.link = function(from, to)
    vim.api.nvim_set_hl(0, to, { link = from })
end

M.empty = function(s)
    return s == '' or s == nil
end

M.rfind = function(str, char)
    local revpos = str:reverse():find(char)

    if revpos == nil then
        return nil
    end

    return #str - revpos
end

M.toggle_list = function(prefix)
    for _, buf in ipairs(vim.fn.getbufinfo { buflisted = 1 }) do
        if vim.api.nvim_buf_get_option(buf.bufnr, 'filetype') == 'qf' then
            vim.cmd(prefix == 'c' and 'cclose' or 'lclose')
            return
        end
    end

    vim.cmd(prefix == 'c' and 'copen' or 'lopen')
end

M.map = function(mapping, opts)
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

M.mapstr = function(req, meth)
    return M.empty(meth) and string.format('<cmd>%s<cr>', req)
        or string.format([[<cmd>lua require('%s').%s<cr>]], req, meth)
end

return M
