" vimwiki.vim - ftplugin configuration

" Remap default header level mappings:
nmap <Leader>w= <Plug>VimwikiAddHeaderLevel
nmap <Leader>w- <Plug>VimwikiRemoveHeaderLevel

" Restore original mappings:
nmap <silent><buffer> = <nop>
nmap <silent><buffer> - <Plug>VinegarUp
