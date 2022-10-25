local env, g, o, opt = vim.env, vim.g, vim.o, vim.opt

o.autowrite = true

o.background = 'dark'

opt.cinkeys:remove ':'

o.cursorline = true

o.expandtab = true
o.softtabstop = 4
o.shiftwidth = 4

o.fillchars = 'fold: ,eob: ,vert:│,diff:╱'

o.foldcolumn = '0'
o.foldmethod = 'marker'
o.foldmarker = ' [:, :]'
o.foldnestmax = 2
o.foldtext =
    [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g'). '  [' . (v:foldend - v:foldstart + 1) . ']']]

o.hlsearch = false

opt.isfname:remove '=,'

o.laststatus = 3

o.lazyredraw = true

o.list = true
o.listchars = 'trail:·'

o.modeline = false

o.mouse = ''

opt.matchpairs:append '<:>'

o.number = true
o.relativenumber = true

opt.path:append '**'

o.pumheight = 15

o.scrolloff = 8

opt.shortmess:append 'Ic'

o.showmode = false

o.showtabline = 0

o.spell = false
o.spellcapcheck = ''
o.spellfile = env.XDG_DATA_HOME .. '/nvim/spell/spell.encoding.add'
o.spelllang = 'en_us'

o.splitbelow = true
o.splitright = true

o.swapfile = false

o.termguicolors = true

o.textwidth = 80

o.undodir = env.XDG_DATA_HOME .. '/nvim/undo'
o.undofile = true

o.updatetime = 50

o.wrap = false

local ignore = env.XDG_CONFIG_HOME .. '/git/ignore'
local wig = {}

for line in io.lines(ignore) do
    table.insert(wig, line)
end

g.wildignore = wig
g.wildcharm = '<tab>'
