local M = {}

_G.pr = function(...) vim.pretty_print(...) end

-- Colorscheme [:
-- :]

M.vorfn = function(val_or_fn)
    if type(val_or_fn) == 'function' then return val_or_fn() end

    return val_or_fn
end

M.empty = function(s) return s == '' or s == nil end

M.format = function()
    vim.lsp.buf.format {
        filter = function(client)
            return not vim.tbl_contains({
                'clangd',
                'cssls',
                'html',
                'jdt.ls',
                'jedi_language_server',
                'jsonls',
                'pyright',
                'sqls',
                'sumneko_lua',
                'tsserver',
            }, client.name)
        end,
    }
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
