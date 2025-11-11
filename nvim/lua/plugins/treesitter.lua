return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdateSync',
        lazy = false,
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-lua/plenary.nvim',
            {
                'echasnovski/mini.ai',
                opts = { silent = true },
                event = 'VeryLazy',
            },
        },
        keys = {
            {
                '<leader>T',
                function()
                    local lang_map = { htmldjango = 'html' }
                    local bufnr = vim.api.nvim_get_current_buf()
                    local parser = vim.treesitter.get_parser(bufnr)
                    local lang = parser:lang()
                    local path = (
                        vim.env.NVIM_APPNAME or vim.fn.stdpath('config')
                    )
                        .. ('/after/queries/%s/highlights.scm'):format(
                            lang_map[lang] or lang
                        )

                    if vim.loop.fs_stat(path) then
                        vim.fn.rename(path, path .. '.disabled')
                    elseif vim.loop.fs_stat(path .. '.disabled') then
                        vim.fn.rename(path .. '.disabled', path)
                    end
                    vim.cmd.TSBufToggle('highlight')
                    vim.cmd.TSBufToggle('highlight')
                end,
            },
        },
        opts = {
            auto_install = true,
            ensure_installed = 'all',
            highlight = {
                additional_vim_regex_highlighting = true,
                disable = function(_, bufnr)
                    local lines = vim.api.nvim_buf_line_count(bufnr)
                    local line_cap = 5000

                    if lines >= line_cap then
                        vim.notify_once(
                            ('Disable TreeSitter for bufnr %s; file too large (%s >= %s lines)'):format(
                                bufnr,
                                lines,
                                line_cap
                            )
                        )
                        return true
                    end
                    return false
                end,
                enable = true,
            },
            textobjects = {
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_previous_start = {
                        ['[a'] = '@parameter.inner',
                        ['[s'] = '@class.outer',
                        ['[f'] = '@function.outer',
                        ['[i'] = '@conditional.outer',
                        ['[/'] = '@comment.outer',
                    },
                    goto_previous_end = {
                        ['[A'] = '@parameter.inner',
                        ['[F'] = '@function.outer',
                        ['[I'] = '@conditional.outer',
                    },
                    goto_next_start = {
                        [']a'] = '@parameter.inner',
                        [']s'] = '@class.outer',
                        [']f'] = '@function.outer',
                        [']i'] = '@conditional.outer',
                        [']/'] = '@comment.outer',
                    },
                    goto_next_end = {
                        [']A'] = '@parameter.inner',
                        [']F'] = '@function.outer',
                        [']I'] = '@conditional.outer',
                    },
                },
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        aa = '@parameter.outer',
                        ia = '@parameter.inner',
                        ab = '@block.outer',
                        ib = '@block.inner',
                        as = '@class.outer',
                        is = '@class.inner',
                        aC = '@call.outer',
                        iC = '@call.inner',
                        af = '@function.outer',
                        ['if'] = '@function.inner',
                        ai = '@conditional.outer',
                        ii = '@conditional.inner',
                        aL = '@loop.outer',
                        iL = '@loop.inner',
                    },
                },
            },
        },
    },
    {
        'nvim-treesitter/playground',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        keys = { { '<leader>t', '<cmd>TSPlaygroundToggle<cr>' } },
    },
    {
        'Wansmer/treesj',
        config = true,
        keys = {
            { 'gS', '<cmd>lua require("treesj").toggle()<cr>' },
        },
    },
}
