local M = {}

local fts = {
    extract = {
        lua = { prefix = 'local ' },
        vim = { prefix = 'let ' },
        javascript = { prefix = 'const ' },
        javascriptreact = { prefix = 'const ' },
        sh = { eq = '' },
        typescript = { prefix = 'const ' },
        typescriptreact = { prefix = 'const ' },
    },
    inline = {
        c = 'h',
        cpp = 'h',
    },
    print = {
        javascript = { l = 'console.log(', r = ')' },
        javascriptreact = { l = 'console.log(', r = ')' },
        lua = { l = 'print(', r = ')' },
        python = { l = 'print(', r = ')' },
        typescript = { l = 'console.log(', r = ')' },
        typescriptreact = { l = 'console.log(', r = ')' },
        vim = { l = 'echo ' },
        sh = { l = 'echo "', r = '"' },
    },
}

local function teardown_win(win)
    vim.api.nvim_win_close(win, true)
end

function M.setup_win(method)
    local cword = vim.fn.expand '<cword>'
    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'cursor',
        row = 1,
        col = 0,
        width = 18,
        height = 1,
        style = 'minimal',
        border = 'single',
    })

    if method == 'extract' then
        cword = ''
        vim.cmd 'start'
    end

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { cword })
    vim.keymap.set('i', '<c-c>', '<cmd>q<cr>', { silent = true, buffer = buf })
    vim.keymap.set('n', 'q', '<cmd>q<cr>', { silent = true, buffer = buf })
    vim.keymap.set(
        { 'n', 'i' },
        '<cr>',
        string.format([[<cmd>lua require 'paqs.refactor'.%s(%d)<cr>]], method, win),
        { silent = true, buffer = buf }
    )
end

function M.rename(win)
    local name = vim.fn.getline '.'
    teardown_win(win)

    vim.lsp.buf.rename(name)
    vim.cmd 'stopi | norm l'
end

local rfind = require('utils').rfind

function M.extract(win)
    local name = vim.trim(vim.fn.getline '.')
    teardown_win(win)

    local pos = rfind(name, ',')
    local num = pos and string.sub(name, pos + 2, #name) or '-'
    local prefix = fts.extract[vim.bo.ft].prefix
    local eq = fts.extract[vim.bo.ft].eq
    local extracted = string.sub(name, 1, pos or #name)

    vim.cmd(
        string.format(
            [[cal feedkeys("mrgvc%s\<esc>O%s\<c-a>%s=%s\<c-r>\"\<esc>\<cmd>m%s\<cr>`r")]],
            extracted,
            prefix or '',
            eq or ' ',
            eq or ' ',
            num
        )
    )
    vim.cmd 'stopi'
end

function M.print()
    local ft = fts.print[vim.bo.ft]

    if ft == nil then
        return
    end

    vim.cmd(string.format([[cal feedkeys("mrgv\"ryo%s\<c-r>\"%s\<esc>`r")]], ft.l, ft.r))
end

function M.inline()
    vim.cmd(
        string.format(
            [[cal feedkeys("mrgv\"ry2Wvg_%s\"lydd^/\<c-r>r\<cr>cgn\<c-r>l\<esc>`r")]],
            fts.inline[vim.bo.ft] or ''
        )
    )
end

return M
