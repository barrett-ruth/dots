local au = require('utils').au

-- helper function to parse output
local function parse_output(proc)
    local result = proc:wait()
    local ret = {}
    if result.code == 0 then
        for line in
            vim.gsplit(result.stdout, '\n', { plain = true, trimempty = true })
        do
            -- Remove trailing slash
            line = line:gsub('/$', '')
            ret[line] = true
        end
    end
    return ret
end

-- build git status cache
local function new_git_status()
    return setmetatable({}, {
        __index = function(self, key)
            local ignore_proc = vim.system({
                'git',
                'ls-files',
                '--ignored',
                '--exclude-standard',
                '--others',
                '--directory',
            }, {
                cwd = key,
                text = true,
            })
            local tracked_proc = vim.system(
                { 'git', 'ls-tree', 'HEAD', '--name-only' },
                {
                    cwd = key,
                    text = true,
                }
            )
            local ret = {
                ignored = parse_output(ignore_proc),
                tracked = parse_output(tracked_proc),
            }

            rawset(self, key, ret)
            return ret
        end,
    })
end
local git_status = new_git_status()

return {
    {
        'savq/melange-nvim',
        config = function()
            vim.o.background = 'dark'
            vim.g.melange_enable_font_variants = false
            vim.cmd.colorscheme('melange')
        end,
        event = 'VeryLazy',
        enabled = false,
    },
    {
        'barrett-ruth/live-server.nvim',
        build = 'pnpm add -g live-server',
        cmd = { 'LiveServerStart', 'LiveServerStart' },
        config = true,
        keys = { { '<leader>L', '<cmd>LiveServerToggle<cr>' } },
    },
    {
        'dhruvasagar/vim-zoom',
        keys = { { '<c-w>m' } },
    },
    {
        'echasnovski/mini.pairs',
        config = true,
        event = 'InsertEnter',
    },
    {
        'folke/ts-comments.nvim',
        config = true,
        event = 'VeryLazy',
    },
    {
        'iamcco/markdown-preview.nvim',
        build = 'pnpm up && cd app && pnpm install',
        ft = { 'markdown' },
        config = function()
            vim.cmd([[
                function OpenMarkdownPreview(url)
                    exec "silent !$BROWSER -n --args " . a:url
                endfunction
            ]])
            vim.g.mkdp_auto_close = 0
            vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'
            au('FileType', 'MarkdownKeybind', {
                callback = function(opts)
                    bmap(
                        { 'n', '<leader>m', vim.cmd.MarkdownPreviewToggle },
                        { buffer = opts.buf }
                    )
                end,
            })
        end,
    },
    {
        'jake-stewart/auto-cmdheight.nvim',
    },
    {
        'L3MON4D3/LuaSnip',
        build = 'make install_jsregexp',
        config = function()
            local ls = require('luasnip')

            ls.setup({
                region_check_events = 'InsertEnter',
                delete_check_events = {
                    'TextChanged',
                    'TextChangedI',
                    'InsertLeave',
                },
                ext_opts = {
                    [require('luasnip.util.types').choiceNode] = {
                        active = {
                            virt_text = {
                                {
                                    ' <- ',
                                    vim.wo.cursorline and 'CursorLine'
                                        or 'Normal',
                                },
                            },
                        },
                    },
                },
            })

            ls.filetype_extend('htmldjango', { 'html' })
            ls.filetype_extend('markdown', { 'html' })
            ls.filetype_extend('javascriptreact', { 'javascript', 'html' })
            ls.filetype_extend('typescript', { 'javascript' })
            ls.filetype_extend(
                'typescriptreact',
                { 'javascriptreact', 'javascript', 'html' }
            )

            require('luasnip.loaders.from_lua').lazy_load({
                paths = { '~/.config/nvim/lua/snippets' },
            })
        end,
        keys = {
            -- restore digraph mapping
            { '<c-d>', '<c-k>', mode = 'i' },
            {
                '<c-space>',
                '<cmd>lua require("luasnip").expand()<cr>',
                mode = 'i',
            },
            {
                '<c-h>',
                '<cmd>lua if require("luasnip").jumpable(-1) then require("luasnip").jump(-1) end<cr>',
                mode = { 'i', 's' },
            },
            {
                '<c-l>',
                '<cmd>lua if require("luasnip").jumpable(1) then require("luasnip").jump(1) end<cr>',
                mode = { 'i', 's' },
            },
            {
                '<c-j>',
                '<cmd>lua if require("luasnip").choice_active() then require("luasnip").change_choice(-1) end<cr>',
                mode = 'i',
            },
            {
                '<c-k>',
                '<cmd>lua if require("luasnip").choice_active() then require("luasnip").change_choice(1) end<cr>',
                mode = 'i',
            },
        },
    },
    {
        'laytan/cloak.nvim',
        config = true,
        keys = { { '<leader>c', '<cmd>CloakToggle<cr>' } },
        event = 'BufReadPre .env*',
    },
    {
        'lervag/vimtex',
        ft = { 'plaintext', 'tex' },
    },
    {
        'let-def/texpresso.vim',
        config = function()
            require('texpresso')
            require('utils').au('FileType', 'TeXpresso', {
                pattern = { 'plaintex', 'tex' },
                callback = function(opts)
                    bmap({
                        'n',
                        '<leader>t',
                        function()
                            vim.cmd('TeXpresso %')
                        end,
                    }, { buffer = opts.buf })
                end,
            })
        end,
        ft = { 'plaintex', 'tex' },
    },
    {
        'maxmellon/vim-jsx-pretty',
        ft = {
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
        },
    },
    {
        'nvimdev/hlsearch.nvim',
        config = true,
        event = 'BufReadPre',
    },
    {
        'NvChad/nvim-colorizer.lua',
        opts = {
            filetypes = {
                'config',
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
        event = 'VeryLazy',
        ft = {
            'conf',
            'sh',
            'tmux',
            'zsh',
            unpack(vim.g.markdown_fenced_languages),
        },
    },
    {
        'phaazon/hop.nvim',
        config = function()
            require('hop').setup()
            local hi = require('colors').hi
            hi('HopUnmatched', { none = true })
            hi('HopNextKey', { reverse = true })
        end,
        keys = { { '<c-space>', vim.cmd.HopChar2 } },
    },
    {
        'stevearc/oil.nvim',
        config = function(_, opts)
            require('oil').setup(opts)

            require('utils').au('FileType', 'OilBufremove', {
                pattern = 'oil',
                callback = function(o)
                    local ok, bufremove = pcall(require, 'mini.bufremove')
                    bmap(
                        { 'n', 'q', ok and bufremove.delete or vim.cmd.bd },
                        { buffer = o.buf }
                    )
                end,
            })
        end,
        init = function()
            require('utils').au('FileType', 'OilGit', {
                pattern = 'oil',
                callback = function()
                    -- Clear git status cache on refresh
                    local refresh = require('oil.actions').refresh
                    local orig_refresh = refresh.callback
                    refresh.callback = function(...)
                        git_status = new_git_status()
                        orig_refresh(...)
                    end
                end,
            })
        end,
        keys = {
            { '-', '<cmd>e .<cr>' },
            { '_', vim.cmd.Oil },
        },
        event = function()
            if vim.fn.isdirectory(vim.fn.expand('%:p')) == 1 then
                return 'VimEnter'
            end
        end,
        opts = {
            skip_confirm_for_simple_edits = true,
            prompt_save_on_select_new_entry = false,
            float = { border = 'single' },
            view_options = {
                is_hidden_file = function(name, bufnr)
                    local dir = require('oil').get_current_dir(bufnr)
                    local is_dotfile = vim.startswith(name, '.')
                        and name ~= '..'
                    -- if no local directory (e.g. for ssh connections), just hide dotfiles
                    if not dir then
                        return is_dotfile
                    end
                    -- dotfiles are considered hidden unless tracked
                    if is_dotfile then
                        return not git_status[dir].tracked[name]
                    else
                        -- Check if file is gitignored
                        return git_status[dir].ignored[name]
                    end
                end,
            },
            keymaps = {
                ['<c-h>'] = false,
                ['<c-s>'] = 'actions.select_vsplit',
                ['<c-x>'] = 'actions.select_split',
            },
        },
    },
    {
        'echasnovski/mini.bufremove',
        config = true,
        event = 'VeryLazy',
        keys = {
            {
                '<leader>bd',
                '<cmd>lua require("mini.bufremove").delete()<cr>',
            },
            {
                '<leader>bw',
                '<cmd>lua require("mini.bufremove").wipeout()<cr>',
            },
        },
    },
    { 'tommcdo/vim-exchange', event = 'VeryLazy' },
    { 'tpope/vim-abolish', event = 'VeryLazy' },
    {
        'tpope/vim-fugitive',
        cmd = 'Git',
        ft = 'gitcommit',
    },
    { 'tpope/vim-repeat', keys = { '.' } },
    { 'tpope/vim-sleuth', event = 'BufReadPost' },
    { 'tpope/vim-surround', keys = { 'c', 'd', 'v', 'V', 'y' } },
    {
        'tzachar/highlight-undo.nvim',
        config = true,
        keys = { 'u', 'U' },
    },
    {
        'ruifm/gitlinker.nvim',
        config = true,
        keys = { '<leader>gy' },
    },
    {
        'ThePrimeagen/harpoon',
        keys = {
            { '<leader>ha', '<cmd>lua require("harpoon.mark").add_file()<cr>' },
            { '<leader>hd', '<cmd>lua require("harpoon.mark").rm_file()<cr>' },
            {
                '<leader>hq',
                '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>',
            },
            { ']h', '<cmd>lua require("harpoon.ui").nav_next()<cr>' },
            { '[h', '<cmd>lua require("harpoon.ui").nav_prev()<cr>' },
            { '<c-h>', '<cmd>lua require("harpoon.ui").nav_file(1)<cr>' },
            { '<c-j>', '<cmd>lua require("harpoon.ui").nav_file(2)<cr>' },
            { '<c-k>', '<cmd>lua require("harpoon.ui").nav_file(3)<cr>' },
            { '<c-l>', '<cmd>lua require("harpoon.ui").nav_file(4)<cr>' },
        },
    },
    { 'Vimjas/vim-python-pep8-indent', ft = { 'python' } },
    {
        'kana/vim-textobj-user',
        dependencies = {
            'kana/vim-textobj-entire',
            'kana/vim-textobj-indent',
            'kana/vim-textobj-line',
            'preservim/vim-textobj-sentence',
            'whatyouhide/vim-textobj-xmlattr',
        },
        keys = { 'c', 'd', 'v', 'V', 'y', '<', '>' },
    },
}
