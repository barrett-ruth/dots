return {
    'L3MON4D3/LuaSnip',
    config = function()
        local ls = require('luasnip')
        local types = require('luasnip.util.types')

        ls.config.set_config({
            region_check_events = 'InsertEnter',
            delete_check_events = 'TextChanged,TextChangedI,InsertLeave',
            update_events = 'TextChanged,TextChangedI,InsertLeave',
            history = true,
            enable_autosnippets = true,
            ext_opts = {
                [types.choiceNode] = {
                    active = {
                        virt_text = {
                            { ' <- ', 'Normal' },
                        },
                    },
                },
            },
        })

        ls.filetype_extend('htmldjango', { 'html' })
        ls.filetype_extend('javascriptreact', { 'javascript', 'html' })
        ls.filetype_extend('typescript', { 'javascript' })
        ls.filetype_extend('typescriptreact', { 'javascriptreact' })
        ls.filetype_extend('zsh', { 'sh' })

        require('luasnip.loaders.from_lua').lazy_load({
            paths = '~/.config/nvim/lua/snippets',
        })
    end,
    keys = {
        -- restore digraph mapping
        { '<c-d>', '<c-k>', mode = 'i' },
        {
            '<c-s>',
            '<cmd>lua require("luasnip").expand()<cr>',
            mode = 'i',
        },
        {
            '<c-h>',
            '<cmd>lua if require("luasnip").jumpable(-1) then require("luasnip").jump(-1) end<cr>',
            mode = { 'i', 's' },
        },
        {
            '<c-l>',
            '<cmd>lua if require("luasnip").jumpable(1) then require("luasnip").jump(1) end<cr>',
            mode = { 'i', 's' },
        },
        {
            '<c-j>',
            '<cmd>lua if require("luasnip").choice_active() then require("luasnip").change_choice(-1) end<cr>',
            mode = 'i',
        },
        {
            '<c-k>',
            '<cmd>lua if require("luasnip").choice_active() then require("luasnip").change_choice(1) end<cr>',
            mode = 'i',
        },
    },
}
