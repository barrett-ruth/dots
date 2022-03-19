local M = {}

function M.empty(s)
    return s == '' or s == nil
end

function M.save()
    local ft = vim.bo.ft
    local fts = {
        bash = 'shfmt -w -ln=bash',
        sh = 'shfmt -w -ln=posix',
        zsh = 'shfmt -w -ln=bash',
        javascript = 'echo $(cat % | prettierd %) >',
        lua = 'stylua --config-path ~/.config/stylua/stylua.toml',
        python = 'black --skip-string-normalization',
    }
    fts.javascriptreact = fts.javascript
    fts.typescript = fts.javascript
    fts.typescriptreact = fts.javascript

    if fts[ft] == nil then
        return
    end

    local cmd = 'sil :!' .. fts[ft] .. ' %'

    vim.cmd(
        'try | undoj |'
            .. cmd
            .. '\n catch /E790/ |'
            .. cmd
            .. '\n catch | echo "Could not format buffer: "  .. v:exception | endt'
    )
end

function M.bd()
    vim.cmd 'bd'

    local bufnrs = vim.api.nvim_eval "len(getbufinfo({'buflisted':1}))"
    if bufnrs == 1 then
        print 'Last buffer'
    end
end

function M.invert_opt(opt, tl)
    local se = tl and 'setl ' or 'se '
    vim.cmd(se .. 'inv' .. opt)
    vim.cmd(se .. opt .. '?')
end

function M.sitter_reparse()
    package.loaded['plug/treesitter'] = nil
    require 'plug/treesitter'

    vim.cmd 'e!'
    vim.cmd "echo 'File reparsed.'"
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
        vim.cmd "echo 'nvim-cmp enabled'"
    else
        cmp.close()
        vim.cmd "echo 'nvim-cmp disabled'"
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

local make_keymap = function(mapping)
    local opts = { noremap = true, silent = true }

    return { mapping[1], mapping[2], mapping[3], opts }
end

function M.map(mapping)
    vim.api.nvim_set_keymap(unpack(make_keymap(mapping)))
end

function M.bmap(mapping)
    vim.api.nvim_buf_set_keymap(0, unpack(make_keymap(mapping)))
end

function M.mapstr(req, meth)
    return M.empty(meth) and '<cmd>' .. req .. '<cr>' or "<cmd>lua require'" .. req .. "'." .. meth .. '<cr>'
end

return M
