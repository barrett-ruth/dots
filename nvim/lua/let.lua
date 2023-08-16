local g = vim.g

g.mapleader = ' '

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
