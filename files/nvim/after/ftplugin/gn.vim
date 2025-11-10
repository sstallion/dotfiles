" gn.vim - ftplugin configuration

setlocal commentstring=#\ %s
setlocal shiftwidth=2

autocmd BufWritePost *.gn,*.gni silent !gn format %
