se autowrite

se cursorline

se completeopt=menuone,noinsert,noselect

se expandtab tabstop=4

se fillchars=fold:\ ,eob:\ ,vert:│

se nofoldenable
se foldlevel=2
se foldmethod=syntax
se foldnestmax=2

se guicursor+=c:ver25

se ignorecase

se isfname-==,

se list
se listchars=nbsp:·,space:·,trail:·,tab:\ \ 

se matchpairs+=<:>

se nohlsearch
se noswapfile
se noshowmode

se number
se relativenumber

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

lua require 'utils'.set_wig()
