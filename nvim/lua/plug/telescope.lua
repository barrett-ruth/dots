local utils = require 'utils'
local fb_actions = require('telescope').extensions.file_browser.actions
local actions = require 'telescope.actions'
local action_layout = require 'telescope.actions.layout'

require('telescope').setup {
    defaults = {
        borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        path_display = { 'shorten' },
        layout_config = {
            preview_width = 0.6,
        },
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
            find_command = { 'fd', '-a', '-t', 'f', '--strip-cwd-prefix' },
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
            disable_devicons = true,
            mappings = {
                i = {
                    ['<c-a>'] = fb_actions.create,
                    ['<c-d>'] = fb_actions.remove,
                    ['<c-r>'] = fb_actions.rename,
                    ['<c-j>'] = fb_actions.move,
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

map { 'n', '<c-b>', mapstr('telescope', 'extensions.file_browser.file_browser()') }
map {
    'n',
    '<c-e>',
    mapstr('telescope.builtin', "find_files({ cwd = '~/.config'})"),
}
map { 'n', '<c-f>', mapstr('utils', 'files()') }
map { 'n', '<c-g>', mapstr('telescope.builtin', 'live_grep()') }
map {
    'n',
    '<leader>tb',
    mapstr('telescope', "extensions.file_browser.file_browser({ cwd = vim.fn.expand '%:p:h' })"),
}
map { 'n', '<leader>tf', mapstr('telescope.builtin', "find_files({ cwd = vim.fn.expand '%:p:h' })") }
map { 'n', '<leader>tg', mapstr('telescope.builtin', "live_grep({ cwd = vim.fn.expand '%:p:h' })") }
map { 'n', '<leader>th', mapstr('telescope.builtin', 'help_tags()') }
map { 'n', '<leader>tr', mapstr('telescope.builtin', 'resume()') }
map { 'n', '<leader>tt', mapstr('telescope.builtin', 'builtin()') }

map { 'n', '<leader>b', mapstr('telescope.builtin', 'buffers()') }
