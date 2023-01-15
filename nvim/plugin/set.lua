local env, o, opt = vim.env, vim.o, vim.opt

o.autowrite = true

o.breakindent = true

o.cursorline = true

opt.diffopt:append 'linematch:60'

o.expandtab = true

opt.fillchars = { fold = ' ', eob = ' ', vert = '│', diff = '╱' }

o.foldenable = false
o.foldexpr = 'nvim_treesitter#foldexpr()'
o.foldmethod = 'expr'
o.foldminlines = 10
o.foldnestmax = 2
o.foldtext = 'getline(v:foldstart)'

o.hlsearch = false

opt.iskeyword:append '-'

o.laststatus = 3

o.list = true
o.listchars = 'trail:·,tab:··'

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

o.signcolumn = 'no'

o.spellfile = env.XDG_DATA_HOME .. '/nvim/spell/spell.encoding.add'

o.splitbelow = true
o.splitright = true

o.statuscolumn = '%s%=%{v:relnum?v:relnum:v:lnum} '

o.swapfile = false

o.termguicolors = true

o.undodir = env.XDG_DATA_HOME .. '/nvim/undo'
o.undofile = true

o.updatetime = 50
o.wrap = false
