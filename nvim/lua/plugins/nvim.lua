return {
    {
        'barrett-ruth/import-cost.nvim',
        build = 'sh install.sh yarn',
        config = true,
        ft = { 'javascript', 'javascripreact', 'typescript', 'typescriptreact' },
    },
    {
        'iamcco/markdown-preview.nvim',
        build = 'yarn --cwd app install',
        config = function()
            vim.g.mkdp_auto_close = 0
            vim.g.mkdp_refresh_slow = 1
            vim.g.mkdp_page_title = '${name}'
        end,
        ft = 'markdown',
        keys = {
            { '<leader>m', '<cmd>MarkdownPreviewToggle<cr>' },
        },
    },
    {
        'laytan/cloak.nvim',
        config = true,
        keys = {
            { '<leader>c', '<cmd>CloakToggle<cr>' },
        },
        lazy = false,
    },
    {
        'monaqa/dial.nvim',
        config = function()
            local dial = require 'dial.map'
            map { 'n', '<c-a>', dial.inc_normal() }
            map { 'n', '<c-x>', dial.dec_normal() }
            map { 'n', 'g<c-a>', dial.inc_gnormal() }
            map { 'n', 'g<c-x>', dial.dec_gnormal() }
            map { 'x', '<c-a>', dial.inc_visual() }
            map { 'x', '<c-x>', dial.dec_visual() }
            map { 'x', 'g<c-a>', dial.inc_gvisual() }
            map { 'x', 'g<c-x>', dial.dec_gvisual() }
        end,
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup {
                pre_hook = require(
                    'ts_context_commentstring.integrations.comment_nvim'
                ).create_pre_hook(),
            }
        end,
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
        event = 'VeryLazy',
    },
    {
        'nvim-tree/nvim-tree.lua',
        config = function(_, opts)
            local ignore = {}

            for _, v in ipairs(vim.g.wildignore) do
                if v:sub(-1) == '/' then
                    table.insert(ignore, '^' .. v:sub(1, -2) .. '$')
                else
                    table.insert(ignore, v)
                end
            end

            opts = vim.tbl_extend('keep', opts, {
                filters = {
                    custom = ignore,
                    dotfiles = true,
                },
            })

            require('nvim-tree').setup(opts)
        end,
        keys = {
            { '-', '<cmd>NvimTreeToggle .<cr>' },
            {
                '<c-n>',
                function()
                    vim.cmd('NvimTreeToggle ' .. vim.fn.expand '%:h')
                end,
            },
        },
        opts = {
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
                        { key = 'q', action = 'close' },
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
                root_folder_label = ':~:s?$?/',
            },
        },
    },
    {
        'NvChad/nvim-colorizer.lua',
        event = 'BufReadPre',
        ft = vim.g.markdown_fenced_languages,
        opts = {
            filetypes = vim.g.markdown_fenced_languages,
            user_default_options = {
                RRGGBBAA = true,
                AARRGGBB = true,
                css = true,
                rgb_fun = true,
                hsl_fn = true,
                tailwind = true,
                mode = 'foreground',
            },
        },
    },
    {
        'windwp/nvim-autopairs',
        config = true,
        event = 'InsertEnter',
    },
}
