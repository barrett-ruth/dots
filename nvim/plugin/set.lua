local env, g, o, opt = vim.env, vim.g, vim.o, vim.opt

o.expandtab = true

o.fillchars = 'fold: ,eob: ,vert:│,diff:╱'

o.hlsearch = false

opt.iskeyword:append '-'

o.laststatus = 3

o.list = true
o.listchars = 'trail:·'

o.modeline = false

o.mouse = ''

opt.matchpairs:append '<:>'

o.number = true
o.relativenumber = true

opt.path:append '**'

o.shiftwidth = 4

opt.shortmess:append 'aCIsS'

o.showmode = false

o.showtabline = 0

o.spellfile = env.XDG_DATA_HOME .. '/nvim/spell/spell.encoding.add'

o.splitbelow = true
o.splitright = true

o.swapfile = false

o.undodir = env.XDG_DATA_HOME .. '/nvim/undo'
o.undofile = true

o.updatetime = 50

o.wrap = false

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
    '.null-ls*',
    '*.o',
    '*.orig',
    '*.rej',
}
