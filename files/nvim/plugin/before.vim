" before.vim - initial plugin configuration

" Not all plugins work well with the after-directory mechanism. This
" file serves as a replacement for cluttering vimrc with configuration
" for these plugins.

" Disable gutentags if ctags not installed:
if !(executable('ctags') || executable('uctags'))
  let g:gutentags_dont_load = 1
endif

" Disable default vim-tmux-navigator key mappings and save buffers:
let g:tmux_navigator_no_mappings    = 1
let g:tmux_navigator_save_on_switch = 2
