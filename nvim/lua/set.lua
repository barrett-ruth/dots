vim.o.autowrite = true

vim.o.background = 'dark'

vim.opt.cinkeys:remove ':'

vim.o.cursorline = true

vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.o.fillchars = 'fold: ,eob: ,vert:│,diff:╱'

vim.o.foldcolumn = '0'
vim.o.foldmethod = 'marker'
vim.o.foldmarker = ' [:, :]'
vim.o.foldnestmax = 2
vim.o.foldtext =
    [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g'). '  [' . (v:foldend - v:foldstart + 1) . ']']]

vim.o.hlsearch = false

vim.opt.isfname:remove '=,'

vim.o.laststatus = 3

vim.o.lazyredraw = true

vim.o.list = true
vim.o.listchars = 'trail:·'

vim.o.modeline = false

vim.o.mouse = ''

vim.opt.matchpairs:append '<:>'

vim.o.number = true
vim.o.relativenumber = true

vim.opt.path:append '**'

vim.o.pumheight = 15

vim.o.scrolloff = 8

vim.opt.shortmess:append 'Ic'

vim.o.showmode = false

vim.o.showtabline = 0

vim.o.spell = false
vim.o.spellcapcheck = ''
vim.o.spellfile = vim.env.XDG_DATA_HOME .. '/nvim/spell/spell.encoding.add'
vim.o.spelllang = 'en_us'

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.swapfile = false

vim.o.termguicolors = true

vim.o.textwidth = 80

vim.o.undodir = vim.env.XDG_DATA_HOME .. '/nvim/undo'
vim.o.undofile = true

vim.o.updatetime = 50

vim.o.wrap = false

local ignore = vim.env.XDG_CONFIG_HOME .. '/git/ignore'
local wig = {}

for line in io.lines(ignore) do
    table.insert(wig, line)
end

vim.g.wildignore = wig
vim.g.wildcharm = '<tab>'
