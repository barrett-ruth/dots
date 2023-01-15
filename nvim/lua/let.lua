vim.g.mapleader = ' '

vim.g.markdown_fenced_languages = {
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

vim.g.python3_host_prog = vim.env.XDG_CONFIG_HOME .. '/nvim/venv/bin/python'

vim.g.wildignore = {
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
    '.null-ls*',
    '*.o',
    '*.orig',
    '*.rej',
}
