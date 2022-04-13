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

function M.rename_help(win)
    local name = vim.fn.getline '.'
    vim.api.nvim_win_close(win, true)
    vim.lsp.buf.rename(name)
    vim.cmd 'stopinsert'
end

function M.rename()
    local cword = vim.fn.expand '<cword>'
    local opts = {
        relative = 'cursor',
        row = 1,
        col = 0,
        width = string.len(cword) * 3,
        height = 1,
        style = 'minimal',
        border = 'single',
    }
    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, opts)

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { cword })
    vim.api.nvim_buf_set_keymap(
        buf,
        'i',
        '<cr>',
        '<cmd>lua require "plug.refactor(' .. win .. ')<cr>',
        { silent = true }
    )
    vim.api.nvim_buf_set_keymap(buf, 'i', 'q', '<c-c>', { silent = true })
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<cmd>q<cr>', { silent = true })
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
    vim.cmd [[
        cal feedkeys("gv\"ry2WviW\"lydd^/\<c-r>r\<cr>cgn\<c-r>l\<esc>")
    ]]
end

function M.extract()
    vim.ui.input({ prompt = 'Variable name: ' }, function(input)
        if require('utils').empty(input) then
            return
        end

        local pos = M.rfind(input, ',')
        local num = pos and string.sub(input, pos + 2, #input) or '-'
        local prefix = fts.extract[vim.bo.ft].prefix
        local eq = fts.extract[vim.bo.ft].eq
        local name = string.sub(input, 1, pos or #input)

        vim.cmd(string.format(
            [[
                cal feedkeys("mrgvc%s\<esc>O%s\<c-a>%s=%s\<c-r>\"\<esc>\<cmd>m%s\<cr>`r")
            ]],
            name,
            prefix or '',
            eq or ' ',
            eq or ' ',
            num
        ))
    end)
end

return M
