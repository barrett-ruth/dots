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

g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0
