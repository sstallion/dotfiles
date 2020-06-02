" go.vim - plugin configuration

" Use goimports to format sources on save:
let g:go_fmt_command = 'goimports'

" Additional options for gofmt and goimports:
let g:go_fmt_options = {
      \ 'gofmt': '-s',
      \ 'goimports': '-local github.com/sstallion',
      \ }
