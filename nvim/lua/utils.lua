local M = {}

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

function M.refactor_print(before)
    local ft = require('fts').refactor.print[vim.bo.ft]

    vim.cmd(string.format(
        [[
            cal feedkeys("mrgv\"ry%s%s\<c-r>\"%s\<esc>`r")
        ]],
        before and 'O' or 'o',
        ft.l,
        ft.r
    ))
end

function M.refactor_inline()
    vim.cmd [[
        cal feedkeys("gv\"ry2WviW\"lydd^/\<c-r>r\<cr>cgn\<c-r>l\<esc>")
    ]]
end

function M.refactor_extract()
    vim.ui.input({ prompt = 'Variable name: ' }, function(input)
        local pos = M.rfind(input, ',')
        local num = pos and string.sub(input, pos + 2, #input) or '-'
        local name = string.sub(input, 1, pos or #input)

        vim.cmd(string.format(
            [[
                cal feedkeys("mrgvc%s\<esc>O\<c-a> = \<c-r>\"\<esc>\<cmd>m%s\<cr>`r")
            ]],
            name,
            num
        ))
    end)
end

function M.toggle_lsp()
    if next(vim.lsp.buf_get_clients(0)) ~= nil then
        vim.diagnostic.disable()
        print 'Stopped LSP.'
    else
        vim.diagnostic.enable()
        print 'Started LSP.'
    end
end

function M.save()
    local ft = vim.bo.ft
    local fts = require('fts').save

    if M.empty(ft) or fts[ft] == nil then
        return
    end

    local cmd = 'sil! :!' .. fts[ft] .. ' %'
    vim.cmd(
        string.format(
            'try | undoj | %s \n cat /E790/ | %s \n cat | echo "Could not format buffer: "  .. v:exception | endt | norm zz',
            cmd,
            cmd
        )
    )
end

function M.bd()
    require('bufdelete').bufdelete(0)

    local bufnrs = vim.api.nvim_eval "len(getbufinfo({'buflisted':1}))"
    if bufnrs == 1 then
        print 'Last buffer.'
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

    cmd = (prefix == 'c' and QFL or LL) and 'ope' or 'cl'

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
    return M.empty(meth) and string.format('<cmd>%s<cr>', req)
        or string.format("<cmd>lua require '%s'.%s<cr>", req, meth)
end

return M
