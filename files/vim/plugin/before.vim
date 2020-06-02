" before.vim - initial plugin configuration

" Not all plugins work well with the after-directory mechanism. This
" file serves as a replacement for cluttering vimrc with configuration
" for these plugins.

" Automatically open .bin files in hex mode:
let g:hexmode_patterns = '*.bin'

" Never prompt or source local vimrc files in a sandbox:
let g:localvimrc_ask     = 0
let g:localvimrc_sandbox = 0

" Install command aliases for better completion:
let g:session_command_aliases = 1

" Disable default vim-tmux-navigator key mappings and save buffers:
let g:tmux_navigator_no_mappings    = 1
let g:tmux_navigator_save_on_switch = 2

" Configure default vimwiki instance (requires symlink to actual) and
" disable automatic behavior for other Markdown sources:
let g:vimwiki_list = [{'path': '~/.vimwiki',
     \ 'syntax': 'markdown', 'ext': '.md'}]

let g:vimwiki_conceallevel = 0
let g:vimwiki_global_ext = 0

" Suffix and wildignore patterns must be read before loading
" vim-vinegar, otherwise g:netrw_list_hide will be incomplete:
call wildignore#init()
