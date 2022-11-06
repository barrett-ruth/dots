local ls = require 'luasnip'
local types = require 'luasnip.util.types'

ls.config.set_config {
    region_check_events = 'InsertEnter',
    delete_check_events = 'TextChanged,TextChangedI,InsertLeave',
    update_events = 'TextChanged,TextChangedI,InsertLeave',
    history = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = {
                    { ' <- ', 'CursorLine' },
                },
            },
        },
    },
}

ls.filetype_extend('cpp', { 'c' })
ls.filetype_extend('javascriptreact', { 'javascript', 'html' })
ls.filetype_extend('typescript', { 'javascript' })
ls.filetype_extend('typescriptreact', { 'javascriptreact' })
ls.filetype_extend('zsh', { 'sh' })

require('luasnip.loaders.from_lua').lazy_load {
    paths = '~/.config/nvim/lua/snippets',
}

local api = vim.api

map {
    { 'i', 's' },
    '<c-h>',
    function()
        if ls.jumpable(-1) then
            ls.jump(-1)
        else
            local row, col = unpack(api.nvim_win_get_cursor(0))
            pcall(api.nvim_win_set_cursor, 0, { row, col - 1 })
        end
    end,
}
map {
    { 'i', 's' },
    '<c-l>',
    function()
        if ls.jumpable(1) then
            ls.jump(1)
        else
            local row, col = unpack(api.nvim_win_get_cursor(0))
            pcall(api.nvim_win_set_cursor, 0, { row, col + 1 })
        end
    end,
}
map {
    'i',
    '<c-s>',
    function()
        if ls.expandable() then ls.expand() end
    end,
}
map {
    'i',
    '<c-j>',
    function()
        if ls.choice_active() then
            ls.change_choice(-1)
        else
            local row, col = unpack(api.nvim_win_get_cursor(0))
            pcall(api.nvim_win_set_cursor, 0, { row + 1, col })
        end
    end,
}
map {
    'i',
    '<c-k>',
    function()
        if ls.choice_active() then
            ls.change_choice(1)
        else
            local row, col = unpack(api.nvim_win_get_cursor(0))
            pcall(api.nvim_win_set_cursor, 0, { row - 1, col })
        end
    end,
}