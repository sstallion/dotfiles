" init.vim - Neovim configuration

lua require('init')

" Default Options
set autowrite
set autowriteall
set clipboard=unnamedplus
set cursorline
set diffopt=filler,context:3
set nofoldenable
set nohlsearch
set noincsearch
set mouse=a
set number
set pumheight=15
set noruler
set sessionoptions-=buffers
set shortmess+=CIWcs
set noshowcmd
set showmatch
set noshowmode
set showtabline=2
set splitbelow
set splitright
set noswapfile
set switchbuf=useopen,usetab
set termguicolors
set winminheight=0
set nowrap

" Default Indentation
set expandtab
set shiftround
set shiftwidth=4
set tabstop=8
set textwidth=78

" Key Mappings
noremap <C-J> <PageDown>
noremap <C-K> <PageUp>

noremap!        <C-H> <Left>
noremap! <expr> <C-J> wildmenumode() ? '<C-N>' : '<Down>'
noremap! <expr> <C-K> wildmenumode() ? '<C-P>' : '<Up>'
noremap!        <C-L> <Right>

noremap <silent> <Leader>n <Cmd>set hlsearch!<CR>
noremap <silent> <Leader>p <Cmd>set paste!<CR>
noremap <silent> <Leader>r <Cmd>set relativenumber!<CR>
noremap <silent> <Leader>s <Cmd>set spell!<CR>

noremap <silent> [b <Cmd>bprevious<CR>
noremap <silent> ]b <Cmd>bnext<CR>
noremap <silent> [B <Cmd>bfirst<CR>
noremap <silent> ]B <Cmd>blast<CR>

noremap <silent> [l <Cmd>lprevious<CR>
noremap <silent> ]l <Cmd>lnext<CR>
noremap <silent> [L <Cmd>lfirst<CR>
noremap <silent> ]L <Cmd>llast<CR>

noremap <silent> [q <Cmd>cprevious<CR>
noremap <silent> ]q <Cmd>cnext<CR>
noremap <silent> [Q <Cmd>cfirst<CR>
noremap <silent> ]Q <Cmd>clast<CR>

noremap <silent> [t <Cmd>tabprevious<CR>
noremap <silent> ]t <Cmd>tabnext<CR>
noremap <silent> [T <Cmd>tabfirst<CR>
noremap <silent> ]T <Cmd>tablast<CR>

" Disable horizontal scrolling:
map <ScrollWheelLeft> <Nop>
map <ScrollWheelRight> <Nop>

" Remove the "How-to disable mouse" menu item and the separator above it;
" see default-mouse.
aunmenu PopUp.How-to\ disable\ mouse
aunmenu PopUp.-1-

" Stop insert mode when leaving a buffer. This avoids accidental
" insertions when navigating with a mouse.
autocmd BufLeave * stopinsert
