local ignore = {}

-- nvim-tree requires wildignore folders to be in format ^name$
for _, v in ipairs(vim.g.wildignore) do
    if v:sub(-1) == '/' then
        table.insert(ignore, '^' .. v:sub(1, -2) .. '$')
    else
        table.insert(ignore, v)
    end
end

require('nvim-tree').setup {
    filters = {
        custom = ignore,
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
                { key = 'c', action = 'close_node' },
                { key = 'd', action = 'remove' },
                { key = 'g', action = 'cd' },
                { key = 'm', action = 'rename' },
                { key = 'p', action = 'paste' },
                { key = 'r', action = 'rename' },
                { key = 't', action = 'toggle_dotfiles' },
                { key = 'u', action = 'parent_node' },
                { key = 'x', action = 'split' },
                { key = 'y', action = 'copy' },
                { key = '<cr>', action = 'edit' },
                { key = '?', action = 'toggle_help' },
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
    },
    filters = {
        dotfiles = true
    }
}

local utils = require 'utils'
local map, mapstr = utils.map, utils.mapstr

map { 'n', '<c-e>', mapstr 'e .' }
map { 'n', '<leader>e', function() vim.cmd('e ' .. vim.fn.expand '%:h') end }
