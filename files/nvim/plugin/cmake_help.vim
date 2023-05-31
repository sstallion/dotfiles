" cmake_help.vim - displays CMake help in a nice way

if exists('g:loaded_cmake_help')
  finish
endif
let g:loaded_cmake_help = 1

let s:save_cpo = &cpo
set cpo&vim

let g:cmake_help_executable = get(g:, 'cmake_help_executable', 'cmake')

let g:cmake_help_manuals = get(g:, 'cmake_help_manuals',
      \ ['command', 'variable', 'property', 'module', 'policy'])

let g:cmake_help_mode = get(g:, 'cmake_help_mode', 'horiz')

let s:cmake_help_bufname = '[CMake Help]'
let s:cmake_help_bufnr   = 0

" Attempts to display help {entry} found in the CMake {manual},
" returning a non-zero value if successful.
function! s:try_help(manual, entry)
  silent let output = systemlist(
        \ printf('%s --help-%s %s', g:cmake_help_executable, a:manual, a:entry))
  if v:shell_error != 0
    return 0
  endif

  if s:cmake_help_bufnr
    execute printf('bunload %d', s:cmake_help_bufnr)
  endif

  if g:cmake_help_mode ==# 'tab'
    silent execute printf('tabnew %s', s:cmake_help_bufname)
  elseif g:cmake_help_mode ==# 'vert'
    silent execute printf('vnew %s', s:cmake_help_bufname)
  else " g:cmake_help_mode ==# 'horiz'
    silent execute printf('new %s', s:cmake_help_bufname)
  endif
  let s:cmake_help_bufnr = bufnr('%')

  setlocal modifiable
  call append(0, output)
  keepjumps normal! dd
  keepjumps normal! gg

  setlocal nomodifiable
  setlocal nonumber
  setlocal noswapfile
  setlocal bufhidden=unload
  setlocal buflisted
  setlocal buftype=nofile
  setlocal filetype=cmakehelp
  setlocal syntax=rst
  return 1
endfunction

function! s:CMakeHelp(...)
  let entry = a:0 > 0 ? a:1 : expand('<cword>')
  for manual in g:cmake_help_manuals
    if s:try_help(manual, entry)
      return
    endif
  endfor
  echomsg printf("'%s' is not a valid CMake help entry.", entry)
endfunction

command -nargs=? CMakeHelp :call <SID>CMakeHelp(<f-args>)

augroup CMakeHelp
  autocmd!
  autocmd FileType cmake :nmap <buffer> <silent> <S-K> :CMakeHelp<CR>
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
