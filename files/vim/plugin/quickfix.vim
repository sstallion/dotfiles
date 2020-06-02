" quickfix.vim - edit/compile/fix cycle

if !has('quickfix')
  finish
endif

" Executes command {cmd}, automatically adjusting 'cmdheight' to avoid
" extraneous prompting.
function! s:Command(cmd)
  let  cmdheight = &cmdheight
  let &cmdheight = 2
  execute a:cmd
  let &cmdheight = cmdheight
  if !has('gui_running')
    redraw!
  endif
endfunction

" Commands
command -nargs=* -bang Make :call <SID>Command('make<bang> <args>')

" Key Mappings
noremap <silent> <F5> :Make<CR>
noremap <silent> <F6> :Make!<CR>
