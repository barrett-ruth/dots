se autowrite

se cursorline

se cinkeys-=:

se completeopt=menuone,noinsert,noselect

se expandtab

se nofoldenable
se foldlevel=2
se foldmethod=syntax
se foldnestmax=2

se guicursor+=c:ver25

se ignorecase

se isfname-==,

se list listchars=nbsp:·,trail:·,tab:\ \ 

se matchpairs+=<:>

se nohlsearch noswapfile noshowmode

se number relativenumber

se laststatus=3

se lazyredraw

se path+=**

se pumheight=15

se sessionoptions+=winpos,terminal,folds

se shiftwidth=4

se shortmess+=Ic

se signcolumn=auto:1-2

se spellfile=~/.config/nvim/spell/en.utf-8.add

se splitbelow splitright

se showtabline=0

se termguicolors

se undodir=~/.config/nvim/undo undofile

se updatetime=50

se wildcharm=<c-n>

se nowrap

lua << EOF

require 'utils'.set_wig()
vim.cmd 'se fcs=fold:\\ ,eob:\\ ,vert:│ '

EOF
