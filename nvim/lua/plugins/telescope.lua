return {
    {
        'nvim-telescope/telescope.nvim',
        opts = function()
            local actions = require 'telescope.actions'

            return {
                defaults = {
                    file_ignore_patterns = vim.g.wildignore,
                    hidden = false,
                    layout_config = {
                        prompt_position = 'top',
                    },
                    mappings = {
                        i = {
                            ['<c-b>'] = actions.results_scrolling_up,
                            ['<c-f>'] = actions.results_scrolling_down,
                            ['<c-l>'] = actions.smart_send_to_loclist,
                            ['<c-q>'] = actions.smart_send_to_qflist,
                        },
                    },
                    preview = false,
                    prompt_title = '',
                    results_title = false,
                    scroll_strategy = 'limit',
                    sorting_strategy = 'ascending',
                },
                pickers = {
                    find_files = {
                        preview = false,
                    },
                    live_grep = {
                        preview = false,
                    },
                    buffers = {
                        ignore_current_buffer = true,
                        mappings = {
                            i = {
                                ['<c-d>'] = actions.delete_buffer,
                            },
                        },
                        sort_mru = true,
                    },
                    lsp_definitions = { preview = true },
                    lsp_document_symbols = { preview = true, show_line = true },
                    lsp_implementations = { preview = true },
                    lsp_references = { preview = true },
                    lsp_type_definitions = { preview = true },
                    loclist = { preview = true },
                    quickfix = { preview = true },
                },
            }
        end,
        config = function(_, opts)
            local builtin, telescope =
                require 'telescope.builtin', require 'telescope'
            telescope.setup(opts)

            telescope.load_extension 'fzy_native'
            telescope.load_extension 'git_worktree'

            map { 'n', '<c-b>', builtin.buffers }
            map { 'n', '<c-f>', builtin.find_files }
            map { 'n', '<c-g>', builtin.live_grep }

            map { 'n', '<leader>tb', builtin.builtin }
            map { 'n', '<leader>tc', builtin.command_history }
            map {
                'n',
                '<leader>te',
                function()
                    builtin.find_files { cwd = vim.env.XDG_CONFIG_HOME }
                end,
            }
            map {
                'n',
                '<leader>tf',
                function()
                    builtin.find_files { cwd = vim.fn.expand '%:h' }
                end,
            }
            map {
                'n',
                '<leader>tg',
                function()
                    builtin.live_grep { cwd = vim.fn.expand '%:h' }
                end,
            }
            map { 'n', '<leader>th', builtin.help_tags }
            map { 'n', '<leader>tH', builtin.highlights }
            map { 'n', '<leader>tl', builtin.loclist }
            map { 'n', '<leader>tm', builtin.man_pages }
            map { 'n', '<leader>tq', builtin.quickfix }
            map { 'n', '<leader>tr', builtin.resume }
            map {
                'n',
                '<leader>ts',
                function()
                    builtin.find_files { cwd = vim.env.SCRIPTS }
                end,
            }
        end,
        dependencies = {
            'nvim-telescope/telescope-fzy-native.nvim',
            'ThePrimeagen/git-worktree.nvim',
        },
    },
}
