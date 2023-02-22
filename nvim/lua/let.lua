local g = vim.g

g.mapleader = ' '

g.markdown_fenced_languages = {
    'c',
    'cpp',
    'css',
    'html',
    'javascript',
    'javascriptreact',
    'json',
    'lua',
    'python',
    'sql',
    'typescript',
    'typescriptreact',
    'vim',
    'yaml',
}

g.python3_host_prog = vim.env.XDG_CONFIG_HOME .. '/nvim/venv/bin/python'

g.wildignore = {
    'undo/',
    '__pycache__/',
    'build/',
    'node_modules/',
    'venv/',
    'cache/',
    '.git/',
    '.github/',
    '.mypy_cache/',
    '*.exe',
    '*.o',
    '*.orig',
    '*.rej',
}

g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_gzip = 1
g.loaded_logiPat = 1
g.loaded_perl_provider = 0
g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_rplugin = 1
g.loaded_rrhelper = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_tohtml = 1
g.loaded_tutor = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_2html_plugin = 1
