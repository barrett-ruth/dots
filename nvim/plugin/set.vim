se autowrite

se cinkeys-=:

se cmdheight=0

se cursorline

se expandtab softtabstop=4 shiftwidth=4

se fillchars=fold:\ ,eob:\ ,vert:│

se foldcolumn=0
se foldmethod=marker
se foldmarker=[:,:]
se foldnestmax=2
se foldtext=substitute(getline(v:foldstart),'\\t',repeat('\ ',&ts),'g').trim(getline(v:foldend))

se isfname-==,

se matchpairs+=<:>

se nohlsearch noswapfile noshowmode

se number relativenumber

se laststatus=3

se lazyredraw

se list listchars=trail:·

se nomodeline

se nowrap

se path+=**

se pumheight=15

se shortmess+=Ic

se signcolumn=no

se spell spellcapcheck= spelllang=en_us

se splitbelow splitright

se stal=0

se textwidth=80

se undofile

se updatetime=50

lua << EOF
    vim.cmd('se undodir=' .. vim.env.XDG_DATA_HOME .. '/nvim/undo')
    vim.cmd('se spellfile=' .. vim.env.XDG_DATA_HOME .. '/nvim/spell.encoding.add')

    local ignore = vim.env.XDG_CONFIG_HOME .. '/git/ignore'
    local wig = {}

    for line in io.lines(ignore) do
        table.insert(wig, line)
    end

    vim.api.nvim_set_var('wildignore', wig)

    require 'paqs.tree'
EOF
