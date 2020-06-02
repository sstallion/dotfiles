" grep.vim - external grep

if executable('ag')
  set grepprg=ag\ --vimgrep
endif
