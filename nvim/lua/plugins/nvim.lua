local fn = vim.fn

return {
    {
        'barrett-ruth/import-cost.nvim',
        build = 'sh install.sh yarn',
        config = true,
        ft = { 'javascript', 'javascripreact', 'typescript', 'typescriptreact' },
    },
    {
        'iamcco/markdown-preview.nvim',
        build = 'yarn --cwd app install',
        config = function()
            vim.g.mkdp_auto_close = 0
            vim.g.mkdp_refresh_slow = 1
            vim.g.mkdp_page_title = '${name}'
        end,
        ft = 'markdown',
        keys = {
            { '<leader>m', '<cmd>MarkdownPreviewToggle<cr>' },
        },
    },
    {
        'kevinhwang91/nvim-ufo',
        config = function(_, opts)
            vim.o.foldlevel = 99

            require('ufo').setup(opts)

            vim.api.nvim_create_autocmd('BufRead', {
                callback = function(kopts)
                    if not vim.treesitter.highlighter.active[kopts.buf] then
                        require('ufo').detach(kopts.buf)
                        vim.api.nvim_win_set_option(
                            vim.fn.bufwinid(kopts.buf),
                            'foldcolumn',
                            '0'
                        )
                    end
                end,
                group = vim.api.nvim_create_augroup('AUfo', {}),
            })
        end,
        dependencies = {
            'kevinhwang91/promise-async',
        },
        opts = {
            open_fold_hl_timeout = 0,
            fold_virt_text_handler = function(virtText, _, _, width)
                local newVirtText = {}
                local targetWidth = width
                local curWidth = 0

                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = fn.strdisplaywidth(chunkText)

                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end

                table.insert(newVirtText, { ' ... ', 'FoldColumn' })

                return newVirtText
            end,
        },
    },
    {
        'monaqa/dial.nvim',
        config = function()
            local dial_map = require 'dial.map'

            map { 'n', '<c-a>', dial_map.inc_normal() }
            map { 'n', '<c-x>', dial_map.dec_normal() }
            map { 'x', '<c-a>', dial_map.inc_visual() }
            map { 'x', '<c-x>', dial_map.dec_visual() }
            map { 'x', 'g<c-a>', dial_map.inc_gvisual() }
            map { 'x', 'g<c-x>', dial_map.dec_gvisual() }
        end,
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup {
                pre_hook = require(
                    'ts_context_commentstring.integrations.comment_nvim'
                ).create_pre_hook(),
            }
        end,
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
        event = 'VeryLazy',
    },
    {
        'NvChad/nvim-colorizer.lua',
        event = 'BufReadPre',
        ft = vim.g.markdown_fenced_languages,
        opts = {
            filetypes = vim.g.markdown_fenced_languages,
            user_default_options = {
                RRGGBBAA = true,
                AARRGGBB = true,
                css = true,
                rgb_fun = true,
                hsl_fn = true,
                tailwind = true,
                mode = 'foreground',
            },
        },
    },
    {
        'windwp/nvim-autopairs',
        config = true,
        event = 'InsertEnter',
    },
    {
        'nvim-zh/colorful-winsep.nvim',
        opts = {
            highlight = {
                bg = '#282828',
                fg = '#d4be98',
            },
            symbols = {
                '─',
                '│',
                '│',
                '│',
                '│',
                '│',
            },
        },
    },
}
