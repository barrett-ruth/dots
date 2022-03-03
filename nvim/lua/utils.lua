local M = {}

function M.toggle_fold()
    vim.o.foldmethod = vim.o.foldmethod == 'syntax' and 'manual' or 'syntax'
    vim.cmd 'se fdm'
end

function M.toggle_list(prefix)
    QFL = QFL == nil and false or not QFL
    LL = LL == nil and false or not LL

    local cmd = (prefix == 'c' and QFL or LL) and 'ope' or 'cl'

    vim.cmd(prefix .. cmd)
end

function M.files(opts)
    local ok = pcall(require('telescope.builtin').git_files, opts)

    if not ok then
        require('telescope.builtin').find_files(opts)
    end
end

function M.toggle_cmp()
    if CMP == nil then
        CMP = false
    else
        CMP = not CMP
    end

    require('cmp').setup.buffer { enabled = CMP }
    print('cmp ' .. (CMP and 'en' or 'dis') .. 'abled')
end

function M.set_wig()
    local ignore = os.getenv 'XDG_CONFIG_HOME' .. '/git/ignore'
    local wig = {}

    for line in io.lines(ignore) do
        table.insert(wig, line)
    end

    vim.g.netrw_listhide = wig
    vim.api.nvim_set_var('wildignore', wig)
end

function M.empty(s)
    return s == '' or s == nil
end

function M.map(mapping, eopts)
    local opts = { noremap = true, silent = true }

    if eopts then
        for k, v in pairs(eopts) do
            opts[k] = v
        end
    end

    local mode = mapping[1]
    local lhs = mapping[2]
    local rhs = mapping[3]

    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

function M.mapstr(req, meth)
    return M.empty(meth) and '<cmd>' .. req .. '<cr>' or "<cmd>lua require'" .. req .. "'." .. meth .. '<cr>'
end

function M.clean_whitespace()
    local save = vim.fn.winsaveview()
    vim.cmd 'keepp %s/\\s\\+$//e'
    vim.fn.winrestview(save)
end

return M
