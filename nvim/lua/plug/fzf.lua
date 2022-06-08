local actions = require 'fzf-lua.actions'
require('fzf-lua').setup {
    fzf_args = os.getenv 'FZF_DEFAULT_OPTS',
    winopts = {
        preview = {
            hidden = 'hidden',
        },
    },
    buffers = {
        actions = {
            ['ctrl-d'] = { actions.buf_del, actions.resume },
        },
    },
    files = {
        fd_opts = os.getenv('FZF_CTRL_T_COMMAND'):match ' (.*)',
    },
    grep = {
        no_header = true,
        no_header_i = true,
        rg_opts = '--color=always --colors=match:fg:green --colors=path:fg:blue --no-heading --no-line-number --smart-case',
    },
}

local utils = require 'utils'
local map, mapstr = utils.map, utils.mapstr

map { 'n', '<leader>fb', mapstr('fzf-lua', 'buffers()') }
map {
    'n',
    '<leader>fe',
    mapstr('fzf-lua', "files({ cwd = os.getenv 'XDG_CONFIG_HOME' })"),
}
map {
    'n',
    '<c-f>',
    function()
        if vim.api.nvim_eval 'FugitiveHead()' ~= '' then
            require('fzf-lua').git_files()
        else
            require('fzf-lua').files()
        end
    end,
}
map { 'n', '<c-g>', mapstr('fzf-lua', 'live_grep()') }
map { 'n', '<leader>ff', mapstr('fzf-lua', "files({ cwd = vim.fn.expand '%:p:h' })") }
map { 'n', '<leader>fg', mapstr('fzf-lua', "live_grep({ cwd = vim.fn.expand '%:p:h' })") }
map { 'n', '<leader>fs', mapstr('fzf-lua', "files({ cwd = os.getenv 'SCRIPTS' })") }
map { 'n', '<leader>fr', mapstr('fzf-lua', 'resume()') }
