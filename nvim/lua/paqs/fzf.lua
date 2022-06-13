local actions = require 'fzf-lua.actions'

local send_to_ll = function(selected, opts)
    local ll = {}
    for i = 1, #selected do
        local file = require('fzf-lua.path').entry_to_file(selected[i], opts)
        local text = selected[i]:match ':%d+:%d?%d?%d?%d?:?(.*)$'
        table.insert(ll, {
            filename = file.path,
            lnum = file.line,
            col = file.col,
            text = text,
        })
    end

    vim.fn.setloclist(0, ll)
end

local symbols = {
    Class = 'ﴯ',
    Constant = '',
    Constructor = '',
    Enum = '',
    EnumMember = '',
    Field = 'ﰠ',
    Function = '',
    Interface = '',
    Method = '',
    Module = '',
    Operator = '',
    Property = 'ﰠ',
    Reference = '',
    Struct = 'פּ',
    Unit = '塞',
    Variable = 'π',
}

local utils = require 'utils'
local map, mapstr, rfind = utils.map, utils.mapstr, utils.rfind

require('fzf-lua').setup {
    actions = {
        files = {
            ['default'] = actions.file_edit,
            ['ctrl-l'] = send_to_ll,
            ['ctrl-q'] = function(...)
                actions.file_sel_to_qf(...)
                vim.cmd 'ccl'
            end,
            ['ctrl-v'] = actions.file_vsplit,
            ['ctrl-x'] = actions.file_split,
        },
    },
    buffers = {
        actions = {
            ['ctrl-d'] = { actions.buf_del, actions.resume },
        },
        prompt = 'buf> ',
    },
    loclist = { prompt = 'll>' },
    lsp = {
        fzf_opts = {
            ['--with-nth'] = '2..',
            ['--delimiter'] = ':',
        },
        jump_to_single_result = true,
        jump_to_single_result_action = actions.file_vsplit,
        no_header = true,
        prompt = 'lsp> ',
        symbol_fmt = function(s)
            local first, last = s:find 'm', rfind(s, '')
            local color = s:sub(first + 1, last)
            return string.format('[%s%s%s]', s:sub(1, first), symbols[color] or s, s:sub(last + 1, #s))
        end,
        symbol_style = 3,
    },
    files = {
        fd_opts = vim.env.FZF_CTRL_T_COMMAND:match ' (.*)',
        git_icons = false,
        file_icons = false,
    },
    fzf_args = vim.env.FZF_DEFAULT_OPTS,
    grep = {
        exec_empty_query = true,
        file_icons = true,
        git_icons = true,
        rg_opts = '--hidden --color=always --colors=match:fg:green --colors=path:fg:blue --line-number --smart-case',
        no_header_i = true,
        prompt = 'rg> ',
    },
    winopts = {
        preview = {
            hidden = 'hidden',
            scrollbar = false,
        },
    },
    quickfix = { prompt = 'qfl>' },
}

map {
    'n',
    '<leader>fe',
    mapstr('fzf-lua', 'files({ cwd = vim.env.XDG_CONFIG_HOME })'),
}
map { 'n', '<c-f>', mapstr('fzf-lua', 'files()') }
map { 'n', '<c-g>', mapstr('fzf-lua', 'live_grep_native()') }
map { 'n', '<leader>ff', mapstr('fzf-lua', [[files({ cwd = vim.fn.expand '%:p:h' })]]) }
map { 'n', '<leader>fg', mapstr('fzf-lua', [[live_grep_native({ cwd = vim.fn.expand '%:p:h' })]]) }
map { 'n', '<leader>fs', mapstr('fzf-lua', 'files({ cwd = vim.env.SCRIPTS })') }
map { 'n', '<leader>fr', mapstr('fzf-lua', 'resume()') }
