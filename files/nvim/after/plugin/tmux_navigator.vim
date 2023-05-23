" tmux_navigator.vim - plugin configuration

if !exists('$TMUX')
  finish
endif

" Key Mappings
nnoremap <silent> <C-W>h :TmuxNavigateLeft<CR>
nnoremap <silent> <C-W>j :TmuxNavigateDown<CR>
nnoremap <silent> <C-W>k :TmuxNavigateUp<CR>
nnoremap <silent> <C-W>l :TmuxNavigateRight<CR>
