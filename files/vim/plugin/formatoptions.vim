" formatoptions.vim - automatic formatting

if !has('autocmd')
  finish
endif

" Default 'formatoptions' for all file types;
" see: http://stackoverflow.com/a/16033050.
autocmd FileType * setlocal formatoptions-=l formatoptions-=o formatoptions-=r formatoptions-=t

" 'formatoptions' are usually applied to related file types. Rather than
" add duplicate ftplugin entries, we apply them here instead:
autocmd FileType c,cpp,header       setlocal formatoptions+=o formatoptions+=r
autocmd FileType help,markdown,text setlocal formatoptions+=t
