local fn = vim.fn

return {
    {
        'barrett-ruth/emmet.nvim',
        build = 'sh install.sh yarn',
        ft = { 'html', 'htmldjango', 'javascriptreact', 'typescriptreact' },
        lazy = true,
        opts = { keymap = '<c-e>' },
    },
    {
        'barrett-ruth/import-cost.nvim',
        build = 'sh install.sh yarn',
        config = true,
        ft = { 'javascript', 'javascripreact', 'typescript', 'typescriptreact' },
        lazy = true,
    },
    {
        'barrett-ruth/live-server.nvim',
        build = 'yarn global add live-server',
        config = true,
        ft = { 'css', 'html', 'javascript' },
        keys = {
            { '<leader>ls', '<cmd>LiveServerStart<cr>' },
            { '<leader>lS', '<cmd>LiveServerStop' },
        },
        lazy = true,
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
        lazy = true,
    },
    {
        'kevinhwang91/nvim-ufo',
        dependencies = {
            'kevinhwang91/promise-async',
        },
        event = 'BufRead',
        lazy = true,
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

            local augend = require 'dial.augend'

            require('dial.config').augends:register_group {
                default = {
                    augend.constant.alias.alpha,
                    augend.constant.alias.Alpha,
                    augend.integer.alias.binary,
                    augend.constant.alias.bool,
                    augend.date.alias['%d/%m/%Y'],
                    augend.integer.alias.decimal_int,
                    augend.integer.alias.hex,
                    augend.integer.alias.octal,
                    augend.semver.alias.semver,
                },
            }
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
    },
    {
        'NvChad/nvim-colorizer.lua',
        ft = vim.g.markdown_fenced_languages,
        lazy = true,
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
    },
}
