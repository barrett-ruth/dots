local gitignore = {}
for _, v in ipairs(vim.g.wildignore) do
    table.insert(gitignore, '^' .. v:sub(1, #v - 1) .. '$')
end

require('nvim-tree').setup {
    filters = {
        custom = gitignore,
    },
    actions = {
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
                { key = 'd', action = 'remove' },
                { key = 'f', action = 'cd' },
                { key = 'm', action = 'rename' },
                { key = 'p', action = 'parent_node' },
                { key = 'q', action = 'close' },
                { key = '<cr>', action = 'edit' },
                { key = 'v', action = 'vsplit' },
                { key = 'x', action = 'split' },
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
}

local utils = require 'utils'
local map, mapstr = utils.map, utils.mapstr

map { 'n', '<c-n>', mapstr 'NvimTreeCollapse' .. mapstr 'NvimTreeToggle' }
map { 'n', '<leader>n', mapstr 'NvimTreeFindFileToggle' }
