" whitespace.vim - plugin configuration

let g:whitespace_ignore = [
      \ 'diff',
      \ 'git',
      \ ]

" Ignore tabs for other git file types. This prevents unnecessary
" modification when git is configured to use vim as an editor:
let g:whitespace_ignore_tabs = [
      \ 'gitcommit',
      \ 'gitconfig',
      \ 'gitrebase',
      \ 'gitsendemail',
      \ ]
