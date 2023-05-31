" c.vim - ftplugin configuration

setlocal cindent
setlocal cinoptions=:0,l1,g0,t0
if &expandtab
  setlocal cinoptions+=(0
else
  setlocal cinoptions+=+4,(0,W4
endif

" Do not repeat C++-style comments on the next line:
setlocal comments-=:// comments+=f://
