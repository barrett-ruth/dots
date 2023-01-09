local api = vim.api
local au = api.nvim_create_autocmd

local aug = api.nvim_create_augroup('augs', {})

au('BufEnter', {
    command = 'setl formatoptions-=cro spelloptions=camel,noplainbuffer',
    group = aug,
})

au('BufWritePost', {
    pattern = vim.env.XDG_CONFIG_HOME .. '/nvim/lua/plugins.lua',
    command = 'so|PaqClean|PaqUpdate|PaqInstall',
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
    callback = function()
        vim.highlight.on_yank { higroup = 'RedrawDebugNormal', timeout = '700' }
    end,
    group = aug,
})
