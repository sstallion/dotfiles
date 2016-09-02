" fastescape.vim - leave insert mode immediately

if !has('autocmd')
  finish
endif

" Leaving insert mode can result in a noticeable delay when using
" plugins like lightline that update the statusline;
" see: http://stackoverflow.com/a/15550787.
augroup FastEscape
  autocmd!
  autocmd InsertEnter *
        \ let s:timeoutlen = &timeoutlen |
        \ let  &timeoutlen = 0
  autocmd InsertLeave *
        \ let  &timeoutlen = s:timeoutlen
augroup END
