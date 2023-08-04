" ginit.vim - Neovim Qt configuration

" Set Editor Font
if exists(':GuiFont')
  if has('win32')
    GuiFont DroidSansM\ Nerd\ Font\ Mono:h11
  else
    GuiFont DroidSansM\ Nerd\ Font\ Mono:h14
  endif
endif

" Disable GUI Tabline
if exists(':GuiTabline')
    GuiTabline 0
endif

" Disable GUI Popupmenu
if exists(':GuiPopupmenu')
    GuiPopupmenu 0
endif

" Enable GUI ScrollBar
if exists(':GuiScrollBar')
    GuiScrollBar 1
endif

" Key Mappings (macOS)
nnoremap <D-v> a<C-r>+<Esc>
inoremap <D-v> <C-r>+
cnoremap <D-v> <C-r>+

noremap  <D-w> <Esc>:qa!<CR>
noremap! <D-w> <Esc>:qa!<CR>

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv
