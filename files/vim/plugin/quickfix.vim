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

noremap <silent> [q :cprev!<CR>
noremap <silent> ]q :cnext!<CR>

noremap <silent> [l :lprev!<CR>
noremap <silent> ]l :lnext!<CR>

" Automatically open and close the QuickFix window after :make;
" see: http://vim.wikia.com/wiki/Automatically_open_the_quickfix_window_on_:make.
augroup QuickFix
  autocmd!
  autocmd QuickFixCmdPost [^l]* nested cwindow
  autocmd QuickFixCmdPost    l* nested lwindow
augroup END
