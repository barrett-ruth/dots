return {
    {
        'lewis6991/gitsigns.nvim',
        event = 'BufReadPre',
        opts = {
            attach_to_untracked = false,
            on_attach = function()
                vim.o.signcolumn = 'yes'

                bmap { 'n', '<leader>ga', '<cmd>diffget //2<cr>' }
                bmap { 'n', '<leader>gf', '<cmd>diffget //3<cr>' }

                local gitsigns = require 'gitsigns'

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

                local fzf = require 'fzf-lua'

                bmap { 'n', '<leader>gb', fzf.git_branches }
                bmap { 'n', '<leader>gc', fzf.git_commits }
                bmap { 'n', '<leader>gh', fzf.git_bcommits }
            end,
            signs = {
                add = { text = '│' },
                change = { text = '│' },
                changedelete = { text = '~' },
                delete = { text = '＿' },
                topdelete = { text = '‾' },
            },
            update_debounce = 0,
        },
    },
    { 'tpope/vim-fugitive', cmd = 'Git' },
    {
        'ThePrimeagen/git-worktree.nvim',
        config = function()
            map { 'n', '<leader>gw', require('worktree').git_worktrees }
        end,
    },
}
