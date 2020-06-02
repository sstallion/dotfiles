" command-t.vim - plugin configuration

" Default to `git ls-files`, including untracked files;
" see: https://github.com/wincent/command-t/pull/235.
let g:CommandTFileScanner         = 'git'
let g:CommandTGitScanSubmodules   = 1
let g:CommandTGitIncludeUntracked = 1

" Traverse to SCM root from working directory:
let g:CommandTTraverseSCM = 'dir'

" Occupy as much (or little) space as possible:
let g:CommandTMaxHeight = 0
let g:CommandTMinHeight = 0

" Highlight Groups
let g:CommandTCursorColor    = 'Cursor'
let g:CommandTHighlightColor = 'Wildmenu'

" Key Mappings
let g:CommandTCancelMap = ['<C-C>', '<Esc>']

" Show matches in buffer window in MRU order:
nnoremap <silent> <Leader>b :CommandTMRU<CR>

" Prior to version 5.0, the following is needed to work with tabs;
" see: https://github.com/wincent/command-t/issues/237.
function! s:BufHidden(buffer)
  let bufno = bufnr(a:buffer)
  let listed_buffers = ''

  redir => listed_buffers
  silent ls
  redir END

  for line in split(listed_buffers, "\n")
    let components = split(line)
    if components[0] == bufno
      return match(components[1], 'h') != -1
    endif
  endfor
  return 0
endfunction

function! s:GotoOrOpen(command_and_args)
  let l:command_and_args = split(a:command_and_args, '\v^\w+ \zs')
  let l:command = l:command_and_args[0]
  let l:file = l:command_and_args[1]

  " bufwinnr() doesn't see windows in other tabs, meaning we open them again
  " instead of switching to the other tab; but bufexists() sees hidden
  " buffers, and if we try to open one of those, we get an unwanted split.
  if bufwinnr(l:file) != -1 || (bufexists(l:file) && !s:BufHidden(l:file))
    execute 'sbuffer ' . l:file
  else
    execute l:command . l:file
  endif
endfunction

command! -nargs=+ GotoOrOpen call s:GotoOrOpen(<q-args>)

let g:CommandTAcceptSelectionCommand = 'GotoOrOpen e'
let g:CommandTAcceptSelectionTabCommand = 'GotoOrOpen tabe'
let g:CommandTAcceptSelectionSplitCommand = 'GotoOrOpen sp'
let g:CommandTAcceptSelectionVSplitCommand = 'GotoOrOpen vs'
