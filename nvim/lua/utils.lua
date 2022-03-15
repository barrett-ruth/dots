local M = {}

function M.empty(s)
    return s == '' or s == nil
end

function M.format(ft)
    if ft and vim.fn.count(vim.g.format_fts, ft) < 1 then
        return
    end

    vim.cmd [[
        try
            undoj
            sil Neoformat
        catch /E790/
            sil Neoformat
        endt
    ]]
end

function M.sitter_reparse()
    package.loaded['plug/treesitter'] = nil
    require 'plug/treesitter'

    vim.cmd 'e!'
end

function M.Q()
    local reg = vim.fn.reg_recording()

    if M.empty(reg) and not M.empty(REG) then
        vim.cmd('norm! @' .. REG)
    elseif reg ~= '' then
        vim.api.nvim_command 'norm! q'
        REG = reg
    end
end

function M.toggle_list(prefix)
    if prefix == 'c' then
        if next(vim.fn.getqflist()) == nil then
            QFL = false
        else
            QFL = not QFL
        end
    else
        if next(vim.fn.getloclist(0)) == nil then
            LL = false
        else
            LL = not LL
        end
    end

    local cmd = ''

    if prefix == 'c' then
        cmd = QFL and 'ope | winc w' or 'cl'
    else
        cmd = LL and 'ope | winc w' or 'cl'
    end

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

    local cmp = require 'cmp'

    cmp.setup.buffer { enabled = CMP }

    if CMP then
        cmp.complete()
    else
        cmp.close()
    end
end

function M.set_wig()
    local ignore = os.getenv 'XDG_CONFIG_HOME' .. '/git/ignore'
    local wig = {}

    for line in io.lines(ignore) do
        table.insert(wig, line)
    end

    vim.api.nvim_set_var('wildignore', wig)
end

function M.map(mapping)
    local opts = { noremap = true, silent = true }

    local mode = mapping[1]
    local lhs = mapping[2]
    local rhs = mapping[3]

    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

function M.bmap(mapping)
    local opts = { noremap = true, silent = true }

    local mode = mapping[1]
    local lhs = mapping[2]
    local rhs = mapping[3]

    vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
end

function M.mapstr(req, meth)
    return M.empty(meth) and '<cmd>' .. req .. '<cr>' or "<cmd>lua require'" .. req .. "'." .. meth .. '<cr>'
end

return M
