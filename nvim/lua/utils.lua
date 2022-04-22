local M = {}

function M.empty(s)
    return s == '' or s == nil
end

function M.save()
    vim.cmd 'w'
    vim.lsp.buf.formatting()
end

function M.source()
    local file = string.match(vim.fn.expand '%', 'lua/(.*).lua')

    if vim.bo.ft == 'lua' then
        package.loaded[file] = nil
    end

    vim.cmd 'so %'
end

function M.bd()
    require('bufdelete').bufdelete(0)

    local bufnrs = vim.api.nvim_eval "len(getbufinfo({'buflisted':1}))"
    if bufnrs == 1 then
        print 'Last buffer.'
    end
end

function M.sitter_reparse()
    package.loaded['plug/treesitter'] = nil
    require 'plug/treesitter'

    vim.cmd 'e'
    vim.cmd "echo 'File reparsed.'"
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

    local cmp = require 'cmp'
    cmp.setup.buffer { enabled = CMP }

    if CMP then
        cmp.complete()
        print 'nvim-cmp enabled.'
    else
        cmp.close()
        print 'nvim-cmp disabled.'
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
