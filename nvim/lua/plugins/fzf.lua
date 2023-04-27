local fd_opts = vim.env.FZF_CTRL_T_COMMAND:match ' (.*)'

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

return {
    'ibhagwan/fzf-lua',
    config = function(_, opts)
        local actions, fzf = require 'fzf-lua.actions', require 'fzf-lua'
        opts = vim.tbl_extend('keep', opts, {
            actions = {
                files = {
                    ['default'] = actions.file_edit,
                    ['ctrl-h'] = {
                        function(_, args)
                            if args.cmd:find '--hidden' then
                                args.cmd = args.cmd:gsub('--hidden', '', 1)
                            else
                                args.cmd = args.cmd .. ' --hidden'
                            end
                            fzf.files(args)
                        end,
                    },
                    ['ctrl-l'] = send_to_ll,
                    ['ctrl-q'] = function(...)
                        actions.file_sel_to_qf(...)
                        vim.cmd.cclose()
                    end,
                    ['ctrl-v'] = actions.file_vsplit,
                    ['ctrl-x'] = actions.file_split,
                },
            },
            border = 'single',
            buffers = {
                actions = {
                    ['ctrl-d'] = { actions.buf_del, actions.resume },
                },
            },
        })

        fzf.setup(opts)

        map { 'n', '<c-b>', fzf.buffers }
        map { 'n', '<c-f>', fzf.files }
        map { 'n', '<c-g>', fzf.live_grep_native }

        map {
            'n',
            '<leader>fe',
            function()
                fzf.files { cwd = vim.env.XDG_CONFIG_HOME }
            end,
        }
        map {
            'n',
            '<leader>ff',
            function()
                fzf.files { cwd = vim.fn.expand '%:h' }
            end,
        }
        map {
            'n',
            '<leader>fg',
            function()
                fzf.live_grep_native { cwd = vim.fn.expand '%:h' }
            end,
        }
        map { 'n', '<leader>fh', fzf.help_tags }
        map { 'n', '<leader>fH', fzf.highlights }
        map { 'n', '<leader>fm', fzf.man_pages }
        map { 'n', '<leader>fr', fzf.resume }
        map {
            'n',
            '<leader>fs',
            function()
                fzf.files { cwd = vim.env.SCRIPTS }
            end,
        }
    end,
    opts = {
        debug = true,
        global_resume = true,
        global_resume_query = true,
        files = {
            fd_opts = fd_opts,
            git_icons = false,
            file_icons = false,
        },
        fzf_args = vim.env.FZF_DEFAULT_OPTS,
        grep = {
            no_header_i = true,
        },
        loclist = {
            path_shorten = true,
        },
        lsp = {
            jump_to_single_result = true,
            symbols = {
                symbol_hl_prefix = '@',
                symbol_style = 3,
            },
        },
        winopts = {
            preview = {
                hidden = 'hidden',
            },
        },
        diagnostics = {
            file_icons = false,
        },
        quickfix = {
            path_shorten = true,
        },
    },
}
