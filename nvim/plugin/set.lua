local o, opt = vim.o, vim.opt

o.autowrite = true

o.background = vim.env.THEME

o.breakindent = true

opt.diffopt:append('linematch:60')

o.expandtab = true

opt.fillchars = {
    fold = ' ',
    foldopen = 'v',
    foldclose = '>',
    foldsep = ' ',
    eob = ' ',
    vert = '│',
    diff = '╱',
}

o.foldlevel = 99
o.foldmethod = 'expr'
o.foldminlines = 9
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- TODO: default to '' on 0.10
opt.foldtext = 'v:lua.vim.treesitter.foldtext()'

opt.iskeyword:append('-')

o.laststatus = 3

o.list = true
opt.listchars = {
    space = ' ',
    trail = '·',
    tab = '  ',
}

opt.matchpairs:append('<:>')

o.modeline = false

o.number = true
o.relativenumber = true

opt.path:append('**')

o.pumheight = 10

o.shiftwidth = 4

opt.shortmess:append('acCIs')

o.showmode = false

o.showtabline = 0

o.spellfile = vim.env.XDG_DATA_HOME .. '/nvim/spell.encoding.add'

o.splitkeep = 'screen'

o.splitbelow = true
o.splitright = true

o.swapfile = false

o.termguicolors = true

o.undodir = vim.env.XDG_DATA_HOME .. '/nvim/undo'
o.undofile = true

o.updatetime = 50
o.wrap = false
