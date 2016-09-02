" complete.vim - insert mode completion

if !has('insert_expand')
  finish
endif

" Enable popup menu for completion and avoid using the first item if
" patch-7.4.775 is included:
set completeopt=menu
if v:version > 704 || v:version == 704 && has('patch775')
  set completeopt+=noinsert,noselect
endif

" Convenience mapping for <C-Space> to <C-X><C-S> when spell checking is
" enabled, otherwise <C-X><C-O>:
inoremap <expr> <C-Space> has('spell') && &spell ? '<C-X><C-S>' : '<C-X><C-O>'
imap <C-@> <C-Space>

" Convenience mappings for the popup menu in insert mode:
inoremap <expr> <Esc> pumvisible() ? '<C-E>' : '<Esc>'
inoremap <expr> <CR>  pumvisible() ? '<C-Y>' : '<CR>'
inoremap <expr> <C-J> pumvisible() ? '<C-N>' : '<C-J>'
inoremap <expr> <C-K> pumvisible() ? '<C-P>' : '<C-K>'

" Enable syntax code completion if 'omnifunc' is unset for filetype;
" see: ft-syntax-omni.
if has('autocmd') && exists('+omnifunc')
  autocmd Filetype *
        \ if &omnifunc == '' |
        \   setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
endif
