" netrw.vim - plugin configuration

" Display human-readable file sizes:
let g:netrw_sizestyle = 'H'

" Sort directories and coredumps first:
let g:netrw_sort_sequence = '[\/]$,\<core\%(\.\d\+\)\='

" Disable special syntax in browser:
let g:netrw_special_syntax = 0
