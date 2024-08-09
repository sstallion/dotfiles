" init.vim - Neovim configuration

call plug#begin()
Plug 'MattesGroeger/vim-bookmarks'
"Plug 'akinsho/bufferline.nvim'
Plug 'akinsho/git-conflict.nvim'
Plug 'catppuccin/nvim'
Plug 'chrishrb/gx.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'epwalsh/obsidian.nvim'
Plug 'folke/trouble.nvim'
Plug 'gbprod/yanky.nvim'
"Plug 'jedrzejboczar/possession.nvim'
Plug 'junegunn/vim-plug'
Plug 'lewis6991/gitsigns.nvim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mhinz/vim-grepper'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
"Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'sstallion/bufferline.nvim' " see: akinsho/bufferline.nvim #763
Plug 'sstallion/lualine.nvim'    " see: nvim-lualine/lualine.nvim #1052
Plug 'sstallion/possession.nvim' " see: jedrzejboczar/possession.nvim #35
Plug 'sstallion/vim-cursorline'
Plug 'sstallion/vim-wildignore'
Plug 'ten3roberts/qf.nvim'
Plug 'tom-anders/telescope-vim-bookmarks.nvim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'wincent/terminus'
call plug#end()

" Abort initialization if installing plugins:
if exists('g:plug_install')
  finish
endif

" Default Options
set autowrite
set autowriteall
set nobackup
set clipboard=unnamed
set cursorline
set diffopt=filler,context:3
set noerrorbells
set nofoldenable
set nohlsearch
set noincsearch
set nolazyredraw
set modeline
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
set timeoutlen=2000
set ttimeoutlen=0
set updatetime=100
set wildmode=longest:list
set winminheight=0
set nowrap

" Default Indentation
set shiftround
set shiftwidth=8
set softtabstop=8
set tabstop=8
set textwidth=78

" Key Mappings
noremap <C-J> <PageDown>
noremap <C-K> <PageUp>

noremap <silent> <Leader>n :set hlsearch!<CR>
noremap <silent> <Leader>p :set paste!<CR>
noremap <silent> <Leader>r :set relativenumber!<CR>
noremap <silent> <Leader>s :set spell!<CR>

noremap <silent> [b :bprevious<CR>
noremap <silent> ]b :bnext<CR>
noremap <silent> [B :bfirst<CR>
noremap <silent> ]B :blast<CR>

noremap <silent> [l :lprevious<CR>
noremap <silent> ]l :lnext<CR>
noremap <silent> [L :lfirst<CR>
noremap <silent> ]L :llast<CR>

noremap <silent> [q :cprevious<CR>
noremap <silent> ]q :cnext<CR>
noremap <silent> [Q :cfirst<CR>
noremap <silent> ]Q :clast<CR>

noremap <silent> [t :tabprevious<CR>
noremap <silent> ]t :tabnext<CR>
noremap <silent> [T :tabfirst<CR>
noremap <silent> ]T :tablast<CR>

" Disable horizontal scrolling:
map <ScrollWheelLeft> <Nop>
map <ScrollWheelRight> <Nop>

" Remove the "How-to disable mouse" menu item and the separator above it;
" see: default-mouse.
aunmenu PopUp.How-to\ disable\ mouse
aunmenu PopUp.-1-

" Stop insert mode when leaving a buffer. This avoids accidental
" insertions when navigating with a mouse.
autocmd BufLeave * stopinsert

" Color Scheme
colorscheme catppuccin
