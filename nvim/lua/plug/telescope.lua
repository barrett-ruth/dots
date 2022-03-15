local utils = require 'utils'
local fb_actions = require('telescope').extensions.file_browser.actions
local actions = require 'telescope.actions'
local action_layout = require 'telescope.actions.layout'

require('telescope').setup {
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        mappings = {
            i = {
                ['<c-h>'] = action_layout.toggle_preview,
                ['<c-l>'] = actions.smart_send_to_loclist,
                ['<c-q>'] = actions.smart_send_to_qflist,
            },
        },
    },
    pickers = {
        find_files = {
            hidden = true,
            find_command = { 'fd', '-a', '--type', 'f', '--strip-cwd-prefix' },
        },
        buffers = {
            mappings = {
                i = {
                    ['<c-d>'] = actions.delete_buffer,
                },
            },
        },
    },
    extensions = {
        file_browser = {
            hidden = true,
            mappings = {
                i = {
                    ['<c-a>'] = fb_actions.create,
                    ['<c-d>'] = fb_actions.remove,
                    ['<c-r>'] = fb_actions.rename,
                    ['<c-v>'] = fb_actions.move,
                    ['<c-y>'] = fb_actions.copy,
                },
            },
        },
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
}

require('telescope').load_extension 'aerial'
require('telescope').load_extension 'file_browser'
require('telescope').load_extension 'fzy_native'
require('telescope').load_extension 'git_worktree'

local map = utils.map
local mapstr = utils.mapstr

map { 'n', '<c-a>', mapstr('telescope', 'extensions.aerial.aerial()') }
map { 'n', '<c-b>', mapstr('telescope', 'extensions.file_browser.file_browser()') }
map {
    'n',
    '<c-e>',
    mapstr('telescope.builtin', "find_files({ cwd = os.getenv('XDG_CONFIG_HOME') })"),
}
map { 'n', '<c-f>', mapstr('utils', 'files()') }
map { 'n', '<c-g>', mapstr('telescope.builtin', 'live_grep()') }
map { 'n', '<c-_>', mapstr('telescope.builtin', 'current_buffer_fuzzy_find({ previewer = false })') }

local scopeleader = '<leader>t'

map {
    'n',
    scopeleader .. 'b',
    mapstr('telescope', "extensions.file_browser.file_browser({ cwd = vim.fn.expand '%:p:h' })"),
}
map { 'n', scopeleader .. 'f', mapstr('utils', "files({ cwd = vim.fn.expand '%:p:h' })") }
map { 'n', scopeleader .. 'g', mapstr('telescope.builtin', "live_grep({ cwd = vim.fn.expand '%:p:h' })") }
map { 'n', scopeleader .. 'h', mapstr('telescope.builtin', 'help_tags()') }
map { 'n', scopeleader .. 'r', mapstr('telescope.builtin', 'resume()') }
map { 'n', scopeleader .. 't', mapstr('telescope.builtin', 'builtin()') }

map { 'n', '<leader>bl', mapstr('telescope.builtin', 'buffers()') }
