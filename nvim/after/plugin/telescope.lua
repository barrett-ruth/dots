local telescope = require 'telescope'
local builtin = require 'telescope.builtin'
local actions = require 'telescope.actions'

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ['<c-b>'] = actions.results_scrolling_up,
                ['<c-f>'] = actions.results_scrolling_down,
                ['<c-l>'] = actions.smart_send_to_loclist,
                ['<c-q>'] = actions.smart_send_to_qflist,
            }
        },
        prompt_title = '',
        borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        layout_config = {
            prompt_position = 'top',
        },
        preview = false,
        scroll_strategy = 'limit',
        sorting_strategy = 'ascending',
    },
    pickers = {
        buffers = {
            ignore_current_buffer = true,
            sort_mru = true,
        },
        lsp_document_symbols = {
            show_line = true,
        },
    },
}

telescope.load_extension 'fzy_native'
telescope.load_extension 'git_worktree'

map { 'n', '<c-b>', builtin.buffers }
map {
    'n',
    '<c-f>',
    function()
        local ok = pcall(builtin.git_files)

        if not ok then pcall(builtin.find_files) end
    end,
}
map { 'n', '<c-g>', builtin.live_grep }

map {
    'n',
    '<leader>te',
    function() builtin.find_files { cwd = vim.env.XDG_CONFIG_HOME } end,
}
map {
    'n',
    '<leader>tf',
    function() builtin.find_files { cwd = vim.fn.expand '%:h' } end,
}
map {
    'n',
    '<leader>tg',
    function() builtin.live_grep { cwd = vim.fn.expand '%:h' } end,
}
map { 'n', '<leader>th', builtin.help_tags }
map { 'n', '<leader>tl', builtin.loclist }
map { 'n', '<leader>tm', builtin.man_pages }
map { 'n', '<leader>tq', builtin.quickfix }
map { 'n', '<leader>tr', builtin.resume }
map {
    'n',
    '<leader>ts',
    function() builtin.find_files { cwd = vim.env.SCRIPTS } end,
}
