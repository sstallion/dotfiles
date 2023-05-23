" insert.vim - insert mode completion

" Enable popup menu for completion and avoid using the first item:
set completeopt=menu,noinsert,noselect

" Unify completion behavior under a single key mapping;
" see: complete_CTRL-Y.
function! s:Complete()
  if !pumvisible()
    return &spell ? "\<C-X>s" : "\<C-X>\<C-O>"
  endif
  return ''
endfunction

inoremap <silent> <C-Space> <C-R>=<SID>Complete()<CR>
inoremap <C-@> <C-Space>

" Convenience mappings for the popup menu in insert mode:
inoremap <expr> <Esc> pumvisible() ? '<C-E>' : '<Esc>'
inoremap <expr> <CR>  pumvisible() ? '<C-Y>' : '<CR>'
inoremap <expr> <C-J> pumvisible() ? '<C-N>' : '<C-J>'
inoremap <expr> <C-K> pumvisible() ? '<C-P>' : '<C-K>'

" Enable syntax code completion if 'omnifunc' is unset for filetype;
" see: ft-syntax-omni.
autocmd Filetype *
      \ if &omnifunc == '' |
      \   setlocal omnifunc=syntaxcomplete#Complete |
      \ endif
