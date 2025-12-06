" formatoptions.vim - automatic formatting

" Default 'formatoptions' for all file types:
autocmd FileType * setlocal formatoptions=crqnlj

" 'formatoptions' are usually applied to related file types. Rather than
" add duplicate ftplugin entries, we apply them here instead:
autocmd FileType help,markdown,obsidian
      \ setlocal formatoptions+=t
