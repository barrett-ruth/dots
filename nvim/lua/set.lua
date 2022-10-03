vim.opt.autowrite = true

vim.opt.background = 'dark'

vim.opt.cinkeys:remove ':'

vim.opt.cursorline = true

vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.fillchars = 'fold: ,eob: ,vert:│,diff:╱'

vim.opt.foldcolumn = '0'
vim.opt.foldmethod = 'marker'
vim.opt.foldmarker = ' [:, :]'
vim.opt.foldnestmax = 2
vim.opt.foldtext =
    [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&ts),'g').trim(getline(v:foldend))]]

vim.opt.hlsearch = false

vim.opt.isfname:remove '=,'

vim.opt.laststatus = 3

vim.opt.lazyredraw = true

vim.opt.list = true
vim.opt.listchars = 'trail:·'

vim.opt.modeline = false

vim.opt.mouse:remove 'n'

vim.opt.matchpairs:append '<:>'

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.path:append '**'

vim.opt.pumheight = 15

vim.opt.shortmess:append 'Ic'

vim.opt.showmode = false

vim.opt.showtabline = 0

vim.opt.signcolumn = 'no'

vim.opt.spell = true
vim.opt.spellcapcheck = ''
vim.opt.spellfile = vim.env.XDG_DATA_HOME .. '/nvim/spell/spell.encoding.add'
vim.opt.spelllang = 'en_us'

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.swapfile = false

vim.opt.termguicolors = true

vim.opt.undodir = vim.env.XDG_DATA_HOME .. '/nvim/undo'
vim.opt.undofile = true

vim.opt.updatetime = 50

vim.opt.wrap = false

local ignore = vim.env.XDG_CONFIG_HOME .. '/git/ignore'
local wig = {}

for line in io.lines(ignore) do
    table.insert(wig, line)
end

vim.g.wildignore = wig
