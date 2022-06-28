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

require('fzf-lua').setup {
    global_resume = true,
    global_resume_query = true,
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
    helptags = {
        prompt = 'help> ',
    },
    files = {
        fd_opts = vim.env.FZF_CTRL_T_COMMAND:match ' (.*)',
        git_icons = false,
        file_icons = false,
    },
    fzf_args = vim.env.FZF_DEFAULT_OPTS,
    grep = {
        rg_opts = '--hidden --color=always --colors=match:fg:green --colors=path:fg:blue --line-number --smart-case',
        no_header_i = true,
        prompt = 'rg> ',
    },
    loclist = {
        prompt = 'll> ',
        path_shorten = true,
    },
    lsp = {
        jump_to_single_result = true,
        no_header = true,
        prompt = 'lsp> ',
        symbol_fmt = function(s)
            local rfind = require('utils').rfind
            local first, last = s:find 'm', rfind(s, '')
            local color = s:sub(first + 1, last)
            return string.format(
                '[%s%s%s]',
                s:sub(1, first),
                LSP_SYMBOLS[color] or s,
                s:sub(last + 1, #s)
            )
        end,
        symbol_style = 3,
    },
    winopts = {
        preview = {
            hidden = 'hidden',
            scrollbar = false,
        },
    },
    quickfix = {
        path_shorten = true,
        prompt = 'qfl> ',
    },
}

require 'paqs.fzf.map'
