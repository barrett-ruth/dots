local M = {}

local fts = {
    extract = {
        lua = 'local ',
        vim = 'let ',
    },
    print = {
        javascript = { l = 'console.log(', r = ')' },
        javascriptreact = { l = 'console.log(', r = ')' },
        lua = { l = 'print(', r = ')' },
        python = { l = 'print(', r = ')' },
        typescript = { l = 'console.log(', r = ')' },
        typescriptreact = { l = 'console.log(', r = ')' },
        vim = { l = 'echo ' },
    },
}

function M.empty(s)
    return s == '' or s == nil
end

function M.source()
    local file = string.match(vim.fn.expand '%', 'lua/(.*).lua')

    if vim.bo.ft == 'lua' then
        package.loaded[file] = nil
    end

    vim.cmd 'so %'
end

function M.rfind(str, char)
    local revpos = str:reverse():find(char)

    if revpos == nil then
        return nil
    end

    return #str - revpos
end

function M.refactor_print(before)
    local ft = fts.print[vim.bo.ft]

    if ft == nil then
        return
    end

    vim.cmd(string.format(
        [[
            cal feedkeys("mrgv\"ry%s%s\<c-r>\"%s\<esc>`r")
        ]],
        before and 'O' or 'o',
        ft.l,
        ft.r and ft.r or ''
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
        local prefix = fts.extract[vim.bo.ft]
        local name = string.sub(input, 1, pos or #input)

        vim.cmd(string.format(
            [[
                cal feedkeys("mrgvc%s\<esc>O%s\<c-a> = \<c-r>\"\<esc>\<cmd>m%s\<cr>`r")
            ]],
            name,
            prefix and prefix or '',
            num
        ))
    end)
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
