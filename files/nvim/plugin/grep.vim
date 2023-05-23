" grep.vim - external grep

if executable('rg')
  set grepprg=rg\ --vimgrep
endif
