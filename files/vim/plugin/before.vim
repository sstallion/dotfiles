" before.vim - initial plugin configuration

" Not all plugins work well with the after-directory mechanism. This
" file serves as a replacement for cluttering vimrc with configuration
" for these plugins.

" Disable gutentags if ctags not installed:
if !executable('ctags')
  let g:gutentags_dont_load = 1
endif

" Automatically open .bin files in hex mode:
let g:hexmode_patterns = '*.bin'

" Disable gitgutter if git not installed:
if !executable('git')
  let g:gitgutter_enabled = 0
endif

" Never prompt or source local vimrc files in a sandbox:
let g:localvimrc_ask     = 0
let g:localvimrc_sandbox = 0

" Install command aliases for better completion:
let g:session_command_aliases = 1

" Disable default vim-tmux-navigator key mappings and save buffers:
let g:tmux_navigator_no_mappings    = 1
let g:tmux_navigator_save_on_switch = 2

" Suffix and wildignore patterns must be read before loading
" vim-vinegar, otherwise g:netrw_list_hide will be incomplete:
call wildignore#init()
