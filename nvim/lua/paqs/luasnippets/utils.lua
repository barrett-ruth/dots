local M = {}

local ls = require 'luasnip'
local i, s, t = ls.i, ls.s, ls.t

local function snipopts(trig)
    return { trig = trig, wordTrig = false }
end

M.inline = function(lr)
    local trig = lr[1]

    if trig:len() == 3 and trig:sub(3, 3) ~= ' ' then
        lr[2] = lr[2] .. trig:sub(3, 3)
        lr[1] = trig:sub(1, 2)
    elseif lr[1]:sub(2, 2) == "'" or lr[1]:sub(2, 2) == '"' then
        return s(snipopts(trig), { t(lr[1]), i(1), t(lr[2]:sub(1, 1)), i(2), t(lr[2]:sub(2, 2)) })
    end

    return s(snipopts(trig), { t(lr[1]), i(1), t(lr[2]) })
end

M.newline = function(lr)
    if lr[2]:sub(1, 1) == '}' then
        return s(
            snipopts(lr[2]),
            { t(lr[1]), t { '', '\t' }, i(1), t { '', '' }, t(lr[2]:sub(1, 1)), i(2), t(lr[2]:sub(2, 2)) }
        )
    end

    return s(snipopts(lr[2]), { t(lr[1]), t { '', '\t' }, i(1), t { '', '' }, t(lr[2]) })
end

M.leave_snippet = function()
    if
        ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
        and ls.session.current_nodes[vim.api.nvim_get_current_buf()]
        and not ls.session.jump_active
    then
        ls.unlink_current()
    end
end

return M
