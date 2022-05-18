se autowrite

se cinkeys-=:

se completeopt=menuone,noinsert,noselect

se expandtab tabstop=4 shiftwidth=4

se fillchars=fold:\ ,eob:\ ,vert:│

se foldlevel=2
se foldnestmax=2

se guicursor+=c:ver25

se isfname-==,

se matchpairs+=<:>

se nohlsearch
se noswapfile
se noshowmode

se number relativenumber

se laststatus=3

se lazyredraw

se list listchars=trail:·

se path+=**

se pumheight=15

se shortmess+=Ic

se signcolumn=yes

se spellfile=~/.config/nvim/spell/en.utf-8.add

se splitbelow splitright

se stal=0

se termguicolors

se undodir=~/.config/nvim/undo undofile

se updatetime=50

se wildcharm=<c-n>

se nowrap

lua << EOF
    local ignore = os.getenv 'XDG_CONFIG_HOME' .. '/git/ignore'
    local wig = {}

    for line in io.lines(ignore) do
        table.insert(wig, line)
    end

    vim.api.nvim_set_var('wildignore', wig)

    require 'plug.tree'
EOF
