local M = {}

_G.pr = function(...) vim.pretty_print(...) end

-- Colorscheme [:
M.cs = {
    bg = '#282828',
    black = '#5a524c',
    red = '#ea6962',
    light_red = '#ef938e',
    green = '#a9b665',
    light_green = '#bbc585',
    yellow = '#d8a657',
    light_yellow = '#e1bb7e',
    blue = '#7daea3',
    light_blue = '#9dc2ba',
    purple = '#d3869b',
    light_purple = '#e1acbb',
    cyan = '#89b482',
    light_cyan = '#a7c7a2',
    white = '#d4be98',
    light_white = '#e2d3ba',
    orange = '#e78a4e',
    grey = '#928374',
    light_grey = '#32302f',
    dark_grey = '#45403d',
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

M.link = function(from, to) vim.api.nvim_set_hl(0, to, { link = from }) end

-- :]

M.vorfn = function(val_or_fn)
    if type(val_or_fn) == 'function' then return val_or_fn() end

    return val_or_fn
end

M.empty = function(s) return s == '' or s == nil end

M.format = function()
    if next(vim.lsp.get_active_clients { bufnr = 0 }) then
        vim.lsp.buf.format {
            filter = function(client)
                return not vim.tbl_contains({
                    'clangd',
                    'jdt.ls',
                    'jedi_language_server',
                    'pyright',
                    'sumneko_lua',
                    'tsserver',
                }, client.name)
            end,
        }
    end
end

M.rfind = function(str, char)
    local revpos = str:reverse():find(char)

    if revpos == nil then return nil end

    return #str - revpos
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
