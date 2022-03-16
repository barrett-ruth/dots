require('nvim-rooter').setup {
    rooter_patterns = { '.git', 'package.json', 'package-lock.json', 'venv' },
    trigger_patterns = { '*' },
    manual = false,
}
