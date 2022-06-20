local M = {}

local console = { l = 'console.log(', r = ')' }
local print = { l = 'print(', r = ')' }
local fts = {
    extract = {
        sh = { eq = '' },
    },
    print = {
        javascript = console,
        javascriptreact = console,
        lua = print,
        python = print,
        typescript = console,
        typescriptreact = console,
        vim = { l = 'echo ' },
        sh = { l = 'echo "', r = '"' },
    },
}

local utils = require 'utils'
local empty, rfind = utils.empty, utils.rfind

function M.rename()
    vim.ui.input({
        prompt = string.format('Rename %s to: ', vim.fn.expand '<cword>'),
    }, function(input)
        if empty(input) then
            return
        end

        vim.lsp.buf.rename(input)
    end)
end

function M.extract()
    vim.cmd 'norm gv"ey'

    vim.ui.input({
        prompt = string.format('Extract %s to: ', vim.fn.getreg 'e'),
    }, function(input)
        if empty(input) then
            return
        end

        local pos = rfind(input, ',')
        local num = pos and input:sub(pos + 2, #input) or '-'
        local eq = fts.extract[vim.bo.ft] and fts.extract[vim.bo.ft].eq
        local raw = input:sub(1, pos or #input)
        local extracted_words = vim.split(raw, ' ')
        local name = extracted_words[#extracted_words]

        vim.cmd(
            string.format(
                [[cal feedkeys("mrgvc%s\<esc>O%s%s=%s\<c-r>\"\<esc>\<cmd>m%s\<cr>`r")]],
                name,
                raw,
                eq or ' ',
                eq or ' ',
                num
            )
        )
        vim.cmd 'stopi'
    end)
end

function M.print()
    local ft = fts.print[vim.bo.ft]

    if ft == nil then
        return
    end

    vim.cmd(string.format([[cal feedkeys("mrgv\"ryo%s\<c-r>\"%s\<esc>`r")]], ft.l, ft.r))
end

return M
