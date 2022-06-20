local gitignore = {}
for _, v in ipairs(vim.g.wildignore) do
    table.insert(gitignore, '^' .. v:sub(1, #v - 1) .. '$')
end

require('nvim-tree').setup {
    filters = {
        custom = gitignore,
    },
    respect_buf_cwd = true,
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
                { key = 'h', action = 'dir_up' },
                { key = 'd', action = 'remove' },
                { key = 'l', action = 'cd' },
                { key = 'm', action = 'rename' },
                { key = 'n', action = 'next_sibling' },
                { key = 'p', action = 'prev_sibling' },
                { key = 'q', action = 'close' },
                { key = 'u', action = 'parent_node' },
                { key = 'v', action = 'vsplit' },
                { key = 'x', action = 'split' },
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
