" complete.vim - insert mode completion

if !has('eval') || !has('insert_expand')
  finish
endif

" Enable popup menu for completion and avoid using the first item if
" patch-7.4.775 is included:
set completeopt=menu
if v:version > 704 || v:version == 704 && has('patch775')
  set completeopt+=noinsert,noselect
endif

" Unify completion behavior under a single key mapping;
" see: complete_CTRL-Y.
function! s:Complete(type)
  if !pumvisible()
    if a:type ==# 'spell' && &spell
      return "\<C-X>s"
    elseif a:type ==# 'omni' && &omnifunc
      return "\<C-X>\<C-O>"
    elseif a:type ==# 'keyword'
      return "\<C-X>\<C-I>"
    elseif a:type ==# 'next'
      return "\<C-N>"
    endif
  endif
  return ''
endfunction

imap <C-@> <C-Space>
inoremap <C-Space> <C-R>=<SID>Complete('spell')<CR>
                  \<C-R>=<SID>Complete('omni')<CR>
                  \<C-R>=<SID>Complete('keyword')<CR>
                  \<C-R>=<SID>Complete('next')<CR>

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
