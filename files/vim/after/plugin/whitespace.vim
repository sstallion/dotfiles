" whitespace.vim - plugin configuration

" Ignore tabs for git file types. This prevents unnecessary modification
" when git is configured to use vim as an editor:
let g:whitespace_ignore_tabs = [
      \ 'git',
      \ 'gitcommit',
      \ 'gitconfig',
      \ 'gitrebase',
      \ 'gitsendemail',
      \ ]
