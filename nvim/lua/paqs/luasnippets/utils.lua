local M = {}

local ls = require 'luasnip'

local i, s = ls.i, ls.s
local fmt = require('luasnip.extras.fmt').fmt

local function snipopts(trig) return { trig = trig, wordTrig = false } end

M.basic_inline = function(lr)
    local left = lr[1]:gsub('{', '{{')
    local right = lr[2]:gsub('}', '}}')

    return s(snipopts(lr[1]), fmt(left .. '{}' .. right, { i(1) }))
end

M.inline_with_node = function(lr)
    local left = lr[1]:gsub('{', '{{')
    local right = lr[2]:gsub('}', '}}')

    return s(
        snipopts(lr[1]),
        fmt(
            left
                .. '{}'
                .. right:sub(1, 1)
                .. '{}'
                .. right:sub(right:sub(-1) == '}' and -2 or -1),
            { i(1), i(2) }
        )
    )
end

M.inline_special = function(lr)
    if lr == '({ ' then return s(snipopts(lr), fmt('({{ {} }})', { i(1) })) end
end

M.newline = function(lr)
    local left = lr[1]:gsub('{', '{{')
    local right = lr[2]:gsub('}', '}}')

    return s(snipopts(lr[2]), fmt(left .. '\n\t{}\n' .. right, { i(1) }))
end

M.leave_snippet = function()
    if
        (
            (vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n')
            or vim.v.event.old_mode == 'i'
        )
        and ls.session.current_nodes[vim.api.nvim_get_current_buf()]
        and not ls.session.jump_active
    then
        ls.unlink_current()
    end
end

return M
