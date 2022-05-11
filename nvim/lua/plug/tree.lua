local gitignore = {}
for _, v in ipairs(vim.g.wildignore) do
    table.insert(gitignore, '^' .. v:sub(1, #v - 1) .. '$')
end

vim.g.nvim_tree_add_trailing = 1
vim.g.nvim_tree_respect_buf_cwd = 1
vim.g.nvim_tree_symlink_arrow = ' -> '
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
                { key = 'b', action = 'dir_up' },
                { key = 'c', action = 'close_node' },
                { key = 'd', action = 'remove' },
                { key = 'g', action = 'cd' },
                { key = 'm', action = 'rename' },
                { key = 'n', action = 'next_sibling' },
                { key = 'p', action = 'prev_sibling' },
                { key = 'q', action = 'close' },
                { key = 'u', action = 'parent_node' },
                { key = '<cr>', action = 'edit' },
                { key = '<c-r>', action = 'full_rename' },
                { key = '<c-v>', action = 'vsplit' },
                { key = '<c-x>', action = 'split' },
            },
        },
        number = true,
        relativenumber = true,
    },
    renderer = {
        indent_markers = {
            enable = true,
        },
    },
}

local utils = require 'utils'
local map = utils.map
local mapstr = utils.mapstr

map { 'n', '<c-n>', mapstr 'NvimTreeCollapse' .. mapstr 'NvimTreeToggle' }
map { 'n', '<leader>n', mapstr 'NvimTreeFindFileToggle' }
map {
    'n',
    '<leader>tn',
    function()
        local prev = vim.fn.getcwd()
        vim.cmd('cd ' .. vim.fn.expand '%:p:h')
        vim.cmd [[
            NvimTreeCollapse
            NvimTreeFindFileToggle
        ]]
        vim.cmd('cd ' .. prev)
    end,
}
