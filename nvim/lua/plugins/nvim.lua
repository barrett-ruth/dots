return {
    {
        'iamcco/markdown-preview.nvim',
        build = 'pnpm up && cd app && pnpm install',
        ft = { 'markdown' },
        init = function()
            vim.g.mkdp_page_title = '${name}'
            vim.g.mkdp_theme = 'light'

            vim.cmd([[
                function OpenMarkdownPreview (url)
                    exec "silent ! open -a Chromium -n --args --new-window " . a:url
                endfunction
                let g:mkdp_browserfunc = 'OpenMarkdownPreview'
            ]])
        end,
        keys = { { '<leader>m', vim.cmd.MarkdownPreviewToggle } },
    },
    {
        'NvChad/nvim-colorizer.lua',
        opts = {
            filetypes = {
                'conf',
                'sh',
                'tmux',
                'zsh',
                unpack(vim.g.markdown_fenced_languages),
            },
            user_default_options = {
                RRGGBBAA = true,
                AARRGGBB = true,
                css = true,
                rgb_fun = true,
                hsl_fn = true,
                tailwind = true,
            },
        },
    },
    {
        'stevearc/oil.nvim',
        keys = {
            { '-', '<cmd>e .<cr>' },
            { '_', vim.cmd.Oil },
        },
        lazy = false,
        opts = {
            skip_confirm_for_simple_edits = true,
            prompt_save_on_select_new_entry = false,
            float = {
                border = 'single',
            },
        },
    },
    {
        'tzachar/highlight-undo.nvim',
        config = true,
        event = 'VeryLazy',
    },
}
