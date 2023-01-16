return {
    'nvim-tree/nvim-tree.lua',
    keys = {
        { '-', '<cmd>NvimTreeFindFileToggle .<cr>' },
        {
            '<leader>n',
            function()
                vim.cmd('NvimTreeFindFileToggle ' .. vim.fn.expand '%:h')
            end,
        },
    },
    ft = 'NvimTree',
    lazy = false,
    opts = {
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
                    { key = 'q', action = 'close' },
                    { key = 'r', action = 'rename' },
                    { key = 'R', action = 'full_rename' },
                    { key = 't', action = 'toggle_dotfiles' },
                    { key = 'u', action = 'parent_node' },
                    { key = 'x', action = 'split' },
                    { key = 'y', action = 'copy' },
                    { key = '?', action = 'toggle_help' },
                    { key = '<bs>', action = 'close_node' },
                    { key = '<cr>', action = 'edit' },
                    { key = '<c-v>', action = 'vsplit' },
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
}
