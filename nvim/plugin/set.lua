local env, g, o, opt = vim.env, vim.g, vim.o, vim.opt

o.autowrite = true

o.cursorline = true

opt.diffopt:append 'linematch:60'

o.expandtab = true

opt.fillchars = { fold = ' ', eob = ' ', vert = '│', diff = '╱' }

o.foldcolumn = '0'
o.foldtext =
    [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g'). '  [' . (v:foldend - v:foldstart + 1) . ']']]
o.foldnestmax = 2

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

o.pumheight = 10

o.shiftwidth = 4

opt.shortmess:append 'acCIs'

o.showmode = false

o.showtabline = 0

o.spellfile = env.XDG_DATA_HOME .. '/nvim/spell/spell.encoding.add'

o.splitbelow = true
o.splitright = true

o.swapfile = false

o.undodir = env.XDG_DATA_HOME .. '/nvim/undo'
o.undofile = true

o.updatetime = 50

o.virtualedit = 'all'

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

o.wrap = false
