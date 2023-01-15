return {
    {
        'ThePrimeagen/git-worktree.nvim',
        lazy = true,
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            local gitsigns = require 'gitsigns'

            gitsigns.setup {
                attach_to_untracked = false,
                current_line_blame = true,
                current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
                current_line_blame_opts = { delay = 0 },
                on_attach = function()
                    bmap { 'n', '<leader>f2', '<cmd>diffget //2<cr>' }
                    bmap { 'n', '<leader>f3', '<cmd>diffget //3<cr>' }

                    bmap { 'n', '<leader>gp', gitsigns.preview_hunk }
                    bmap { 'n', '<leader>gs', gitsigns.stage_hunk }
                    bmap { 'n', '<leader>gu', gitsigns.undo_stage_hunk }

                    bmap {
                        'n',
                        '[g',
                        function()
                            gitsigns.prev_hunk { preview = true }
                        end,
                    }
                    bmap {
                        'n',
                        ']g',
                        function()
                            gitsigns.next_hunk { preview = true }
                        end,
                    }

                    local builtin = require 'telescope.builtin'

                    bmap { 'n', '<leader>gb', builtin.git_branches }
                    bmap { 'n', '<leader>gc', builtin.git_commits }
                    bmap { 'n', '<leader>gh', builtin.git_bcommits }

                    local git_worktree =
                        require('telescope').extensions.git_worktree

                    bmap { 'n', '<leader>gw', git_worktree.git_worktrees }
                    bmap { 'n', '<leader>gW', git_worktree.create_git_worktree }
                end,
                preview_config = {
                    border = 'rounded',
                },
                signs = {
                    add = { text = '│' },
                    change = { text = '│' },
                    changedelete = { text = '~' },
                    delete = { text = '＿' },
                    topdelete = { text = '‾' },
                },
                update_debounce = 0,
            }
        end,
    },
    'tpope/vim-fugitive',
}
