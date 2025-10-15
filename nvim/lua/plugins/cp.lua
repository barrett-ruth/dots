return {
    'barrett-ruth/cp.nvim',
    command = 'CP',
    dependencies = {
        'L3MON4D3/LuaSnip',
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        local default_cpp_lang = {
            extension = 'cc',
            commands = {
                build = {
                    'g++',
                    '-std=c++23',
                    '-O2',
                    '-Wall',
                    '-Wextra',
                    '-Wpedantic',
                    '-Wshadow',
                    '-Wconversion',
                    '-Wformat=2',
                    '-Wfloat-equal',
                    '-Wundef',
                    '-fdiagnostics-color=always',
                    '-DLOCAL',
                    '{source}',
                    '-o',
                    '{binary}',
                },
                run = { '{binary}' },
                debug = {
                    'g++',
                    '-std=c++23',
                    '-g3',
                    '-fsanitize=address,undefined',
                    '-fno-omit-frame-pointer',
                    '-fstack-protector-all',
                    '-D_GLIBCXX_DEBUG',
                    '-DLOCAL',
                    '{source}',
                    '-o',
                    '{binary}',
                },
            },
        }

        local default_python_lang = {
            extension = 'py',
            commands = {
                run = { 'python3', '{source}' },
                debug = { 'python3', '{source}' },
            },
        }

        local default_rust_lang = {
            extension = 'rs',
            commands = {
                build = {
                    'rustc',
                    '-O',
                    '--color=always',
                    '-C',
                    'codegen-units=1',
                    '-C',
                    'target-cpu=native',
                    '{source}',
                    '-o',
                    '{binary}',
                },
                run = { '{binary}' },
                debug = {
                    'rustc',
                    '-g',
                    '-C',
                    'overflow-checks=yes',
                    '{source}',
                    '-o',
                    '{binary}',
                },
            },
        }

        require('cp').setup({
            open_url = true,
            languages = {
                cpp = default_cpp_lang,
                python = default_python_lang,
            },
            platforms = {
                codeforces = {
                    enabled_languages = { 'cpp', 'python' },
                    default_language = 'cpp',
                },
                atcoder = {
                    enabled_languages = { 'cpp', 'python' },
                    default_language = 'cpp',
                },
                cses = {},
            },
            ui = { picker = 'fzf-lua' },
            hooks = {
                before_run = function(_)
                    require('lsp').lsp_format({ async = true })
                end,
                before_debug = function(_)
                    require('lsp').lsp_format({ async = true })
                end,
                setup_code = function(state)
                    vim.opt_local.winbar = ''
                    vim.opt_local.foldlevel = 0
                    vim.opt_local.foldmethod = 'marker'
                    vim.opt_local.foldmarker = '{{{,}}}'
                    vim.opt_local.foldtext = ''
                    vim.diagnostic.enable(false)

                    local buf = vim.api.nvim_get_current_buf()
                    local lines = vim.api.nvim_buf_get_lines(buf, 0, 1, true)
                    if #lines > 1 or (#lines == 1 and lines[1] ~= '') then
                        return
                    end

                    local trigger = state.get_platform() or ''
                    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { trigger })
                    vim.api.nvim_win_set_cursor(0, { 1, #trigger })
                    vim.cmd.startinsert({ bang = true })
                    vim.schedule(function()
                        local ls = require('luasnip')
                        if ls.expandable() then
                            ls.expand()
                        end
                        vim.cmd.stopinsert()
                    end)
                end,
            },
        })
    end,
}
