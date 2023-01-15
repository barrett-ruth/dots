local api = vim.api

return {
    {
        'L3MON4D3/LuaSnip',
        config = function()
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
                                { ' <- ', 'Normal' },
                            },
                        },
                    },
                },
            }

            ls.filetype_extend('cpp', { 'c' })
            ls.filetype_extend('htmldjango', { 'html' })
            ls.filetype_extend('javascriptreact', { 'javascript', 'html' })
            ls.filetype_extend('typescript', { 'javascript' })
            ls.filetype_extend('typescriptreact', { 'javascriptreact' })
            ls.filetype_extend('zsh', { 'sh' })

            require('luasnip.loaders.from_lua').lazy_load {
                paths = '~/.config/nvim/lua/snippets',
            }

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
                    if ls.expandable() then
                        ls.expand {}
                    end
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
            -- restore digraph mapping
            map { 'i', '<c-d>', '<c-k>' }
        end,
    },
    {
        'nvim-tree/nvim-tree.lua',
        config = {
            filters = {
                custom = (function()
                    local ignore = {}

                    -- nvim-tree requires wildignore folders to be in format ^name$
                    for _, v in ipairs(vim.g.wildignore) do
                        if v:sub(-1) == '/' then
                            table.insert(ignore, '^' .. v:sub(1, -2) .. '$')
                        else
                            table.insert(ignore, v)
                        end
                    end

                    return ignore
                end)(),
                dotfiles = true,
            },
            actions = {
                change_dir = {
                    enable = false,
                },
                open_file = {
                    quit_on_open = true,
                    window_picker = { enable = false },
                },
            },
            view = {
                signcolumn = 'no',
                mappings = {
                    custom_only = true,
                    list = {
                        { key = 'a', action = 'create' },
                        { key = 'b', action = 'dir_up' },
                        { key = 'c', action = 'cd' },
                        { key = 'd', action = 'remove' },
                        { key = 'p', action = 'paste' },
                        { key = 'r', action = 'rename' },
                        { key = 'R', action = 'full_rename' },
                        { key = 't', action = 'toggle_dotfiles' },
                        { key = 'u', action = 'parent_node' },
                        { key = 'x', action = 'split' },
                        { key = 'y', action = 'copy' },
                        { key = '?', action = 'toggle_help' },
                        { key = '<bs>', action = 'close_node' },
                        { key = '<cr>', action = 'edit' },
                    },
                },
                number = true,
                relativenumber = true,
            },
            renderer = {
                add_trailing = true,
                icons = {
                    symlink_arrow = ' -> ',
                    show = {
                        git = false,
                        folder = false,
                        folder_arrow = false,
                        file = false,
                    },
                },
                indent_markers = {
                    enable = true,
                },
                root_folder_label = ':~:s?$?/?',
            },
        },
        keys = {
            { '-', '<cmd>NvimTreeFindFileToggle .<cr>' },
            {
                '<leader>n',
                function()
                    vim.cmd('NvimTreeFindFileToggle ' .. vim.fn.expand '%:h')
                end,
            },
        },
    },
    {
        'ThePrimeagen/harpoon',
        config = function()
            local mark, ui = require 'harpoon.mark', require 'harpoon.ui'

            map { 'n', '<leader>ha', mark.add_file }
            map { 'n', '<leader>hd', mark.rm_file }

            map { 'n', '<leader>hq', ui.toggle_quick_menu }
            map { 'n', '<leader>hn', ui.nav_next }
            map { 'n', '<leader>hp', ui.nav_prev }

            map {
                'n',
                '<leader>hh',
                function()
                    ui.nav_file(1)
                end,
            }
            map {
                'n',
                '<leader>hj',
                function()
                    ui.nav_file(2)
                end,
            }
            map {
                'n',
                '<leader>hk',
                function()
                    ui.nav_file(3)
                end,
            }
            map {
                'n',
                '<leader>hl',
                function()
                    ui.nav_file(4)
                end,
            }
        end,
    },
}
