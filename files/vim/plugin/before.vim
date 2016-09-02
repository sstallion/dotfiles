" before.vim - initial plugin configuration

" Not all plugins work well with the after-directory mechanism. This
" file serves as a replacement for cluttering vimrc with configuration
" for these plugins.

" Automatically open .bin files in hex mode:
let g:hexmode_patterns = '*.bin'

" Never prompt or source local vimrc files in a sandbox:
let g:localvimrc_ask     = 0
let g:localvimrc_sandbox = 0
