local utils = require 'utils'
local actions = require 'telescope.actions'
local fb_actions = require('telescope').extensions.file_browser.actions
local action_layout = require 'telescope.actions.layout'

require('telescope').setup {
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        mappings = {
            i = { ['<c-h>'] = action_layout.toggle_preview },
        },
    },
    pickers = {
        find_files = {
            hidden = true,
            find_command = { 'fd', '-a', '--type', 'f', '--strip-cwd-prefix' },
        },
        git_branches = {
            mappings = {
                n = {
                    C = actions.git_create_branch,
                    D = actions.git_delete_branch,
                    T = actions.git_track_branch,
                    M = actions.git_merge_branch,
                    R = actions.git_rebase_branch,
                    S = actions.git_checkout,
                },
            },
        },
        git_commits = {
            mappings = {
                n = {
                    RH = actions.git_reset_hard,
                    RM = actions.git_reset_mixed,
                    RS = actions.git_reset_soft,
                    S = actions.git_staging_toggle,
                },
            },
        },
    },
    extensions = {
        file_browser = {
            disable_devicons = true,
            hidden = true,
            mappings = {
                n = {
                    C = fb_actions.create,
                    D = fb_actions.remove,
                    H = fb_actions.toggle_hidden,
                    M = fb_actions.move,
                    R = fb_actions.rename,
                    T = fb_actions.toggle_browser,
                },
            },
        },
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
}

require('telescope').load_extension 'file_browser'
require('telescope').load_extension 'fzy_native'
require('telescope').load_extension 'git_worktree'

local map = utils.map
local mapstr = utils.mapstr

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
map { 'n', scopeleader .. 't', ":lua require 'telescope.builtin'.()<left><left>" }
