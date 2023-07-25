return {
    {
        'axelvc/template-string.nvim',
        config = function(_, opts)
            require('template-string').setup(opts)
        end,
        opts = {
            remove_template_string = true,
        },
    },
    {
        'barrett-ruth/import-cost.nvim',
        build = 'sh install.sh yarn',
        config = true,
        ft = { 'javascript', 'javascripreact', 'typescript', 'typescriptreact' },
    },
    {
        'stevearc/oil.nvim',
        keys = {
            { '-', '<cmd>e .<cr>' },
            { '_', '<cmd>Oil<cr>' },
        },
        opts = {
            skip_confirm_for_simple_edits = true,
            prompt_save_on_select_new_entry = false,
            float = {
                border = 'single',
            },
        },
    },
    {
        'laytan/cloak.nvim',
        config = true,
        ft = { 'sh' },
        keys = { { '<leader>c', '<cmd>CloakToggle<cr>' } },
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function(_, opts)
            require('gitsigns').setup(opts)

            map({ 'n', '<leader>gb', '<cmd>Gitsigns blame_line<cr>' })
            map({ 'n', '<leader>gp', '<cmd>Gitsigns preview_hunk<cr>' })
            map({
                'n',
                '[g',
                '<cmd>lua require("gitsigns").prev_hunk { preview = true }<cr>',
            })
            map({
                'n',
                ']g',
                '<cmd>lua require("gitsigns").next_hunk { preview = true }<cr>',
            })
        end,
        event = 'VeryLazy',
        opts = {
            on_attach = function()
                vim.wo.signcolumn = 'yes'
            end,
            attach_to_untracked = false,
            signs = {
                delete = { text = '＿' },
            },
        },
    },
    {
        'monaqa/dial.nvim',
        keys = {
            {
                '<c-a>',
                '<cmd>lua require("dial.map").manipulate("increment", "normal")<cr>',
            },
            {
                '<c-x>',
                '<cmd>lua require("dial.map").manipulate("decrement", "normal")<cr>',
            },
            {
                'g<c-a>',
                '<cmd>lua require("dial.map").manipulate("increment", "gnormal")<cr>',
            },
            {
                'g<c-x>',
                '<cmd>lua require("dial.map").manipulate("decrement", "gnormal")<cr>',
            },
            {
                '<c-a>',
                '<cmd>lua require("dial.map").manipulate("increment", "visual")<cr>',
                mode = 'x',
            },
            {
                '<c-x>',
                '<cmd>lua require("dial.map").manipulate("decrement", "visual")<cr>',
                mode = 'x',
            },
            {
                'g<c-a>',
                '<cmd>lua require("dial.map").manipulate("increment", "gvisual")<cr>',
                mode = 'x',
            },
            {
                'g<c-x>',
                '<cmd>lua require("dial.map").manipulate("decrement", "gvisual")<cr>',
                mode = 'x',
            },
        },
    },
    {
        'NvChad/nvim-colorizer.lua',
        opts = {
            filetypes = {
                'conf',
                'sh',
                'tmux',
                'zsh',
                unpack(vim.g.markdown_fenced_languages),
            },
            user_default_options = {
                RRGGBBAA = true,
                AARRGGBB = true,
                css = true,
                rgb_fun = true,
                hsl_fn = true,
                tailwind = true,
            },
        },
    },
    { 'windwp/nvim-autopairs', config = true, event = 'InsertEnter' },
}
