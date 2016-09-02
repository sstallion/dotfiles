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

" Key Mappings
let g:CommandTCancelMap = ['<C-C>', '<Esc>']

" Highlight Groups
let g:CommandTCursorColor    = 'Cursor'
let g:CommandTHighlightColor = 'Wildmenu'
