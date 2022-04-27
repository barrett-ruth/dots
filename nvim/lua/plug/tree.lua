local gitignore = {}
for _, v in ipairs(vim.g.wildignore) do
    table.insert(gitignore, '^' .. v .. '$')
end

vim.g.nvim_tree_add_trailing = 1
vim.g.nvim_tree_show_icons = {
    git = 0,
    folders = 0,
    files = 0,
}

require('nvim-tree').setup {
    filters = {
        custom = gitignore,
    },
    actions = {
        open_file = {
            quit_on_open = true,
            resize_window = true,
            window_picker = { enable = false },
        },
    },
    view = {
        signcolumn = 'no',
        hide_root_folder = true,
        mappings = {
            custom_only = true,
            list = {
                { key = 'a', action = 'create' },
                { key = 'd', action = 'remove' },
                { key = 'g', action = 'cd' },
                { key = 'n', action = 'next_sibling' },
                { key = 'p', action = 'prev_sibling' },
                { key = 'r', action = 'rename' },
                { key = 'u', action = 'parent_node' },
                { key = 'q', action = 'close' },
                { key = '<cr>', action = 'edit' },
                { key = '<c-r>', action = 'full_rename' },
                { key = '<c-v>', action = 'vsplit' },
                { key = '<c-x>', action = 'split' },
                { key = 'b', action = 'dir_up' },
                { key = 'c', action = 'close_node' },
            },
        },
        number = true,
        relativenumber = true,
    },
    renderer = {
        indent_markers = {
            enable = true,
            icons = {
                corner = '└ ',
                edge = '│ ',
                none = '  ',
            },
        },
    },
}

local utils = require 'utils'
local map = utils.map
local mapstr = utils.mapstr

map { 'n', '<c-b>', mapstr 'NvimTreeCollapse' .. mapstr 'NvimTreeToggle' }
map { 'n', '<leader>tb', mapstr 'NvimTreeFindFileToggle' }
