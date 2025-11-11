" formatoptions.vim - automatic formatting

" Default 'formatoptions' for all file types:
autocmd FileType * setlocal formatoptions=cqbj

" 'formatoptions' are usually applied to related file types. Rather than
" add duplicate ftplugin entries, we apply them here instead:
autocmd FileType c,cpp,header,lua,verilog,vhdl
      \ setlocal formatoptions+=r

autocmd FileType help,markdown,obsidian
      \ setlocal formatoptions+=tan

autocmd FileType markdown,obsidian
      \ setlocal formatoptions+=w
