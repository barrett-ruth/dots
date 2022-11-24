local api = vim.api
local au = api.nvim_create_autocmd

local aug = api.nvim_create_augroup('augs', {})

au('BufEnter', {
    pattern = '*',
    command = 'setl formatoptions-=cro spelloptions=camel,noplainbuffer',
    group = aug,
})

au('InsertLeave', {
    callback = function()
        local ls = require 'luasnip'

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
    end,
    group = aug,
})

au('TextYankPost', {
    command = [[lua vim.highlight.on_yank { higroup = 'RedrawDebugNormal', timeout = '700' }]],
    group = aug,
})
