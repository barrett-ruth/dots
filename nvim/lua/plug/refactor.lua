local M = {}

local fts = {
    extract = {
        lua = { prefix = 'local ' },
        vim = { prefix = 'let ' },
        sh = { eq = '' },
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

function M.rfind(str, char)
    local revpos = str:reverse():find(char)

    if revpos == nil then
        return nil
    end

    return #str - revpos
end

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
        width = 15,
        height = 1,
        style = 'minimal',
        border = 'single',
    })

    if method == 'extract' then
        cword = ''
        vim.cmd 'startinsert'
    end

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { cword })
    vim.api.nvim_buf_set_keymap(buf, 'i', '<c-c>', '<cmd>q<cr>', { silent = true })
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<cmd>q<cr>', { silent = true })
    print '<cmd>lua require "plug.refactor".%s(%d)<cr>'
    vim.api.nvim_buf_set_keymap(
        buf,
        'i',
        '<cr>',
        string.format('<cmd>lua require "plug.refactor".%s(%d)<cr>', method, win),
        { silent = true }
    )
end

function M.rename(win)
    local name = vim.trim(vim.fn.getline '.')
    teardown_win(win)

    vim.lsp.buf.rename(name)
    vim.cmd 'stopinsert'
end

function M.extract(win)
    local name = vim.trim(vim.fn.getline '.')
    teardown_win(win)

    local pos = M.rfind(name, ',')
    local num = pos and string.sub(name, pos + 2, #name) or '-'
    local prefix = fts.extract[vim.bo.ft].prefix
    local eq = fts.extract[vim.bo.ft].eq
    local extracted = string.sub(name, 1, pos or #name)

    vim.cmd(string.format(
        [[
            cal feedkeys("mrgvc%s\<esc>O%s\<c-a>%s=%s\<c-r>\"\<esc>\<cmd>m%s\<cr>`r")
        ]],
        extracted,
        prefix or '',
        eq or ' ',
        eq or ' ',
        num
    ))
    vim.cmd 'stopinsert'
end

function M.print(before)
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
        ft.r
    ))
end

function M.inline()
    -- TODO: change 2W for sh ft
    vim.cmd [[
        cal feedkeys("gv\"ry2WviW\"lydd^/\<c-r>r\<cr>cgn\<c-r>l\<esc>")
    ]]
end

return M
