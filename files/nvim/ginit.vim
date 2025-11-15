" ginit.vim - Neovide/Neovim Qt configuration

" Set Editor Font
if has('win32')
  set guifont=DroidSansM\ Nerd\ Font\ Mono:h10
else
  set guifont=DroidSansM\ Nerd\ Font\ Mono:h14
endif

if exists(':GuiFont')
  GuiFont &guifont
endif

" Disable Animations
if exists('g:neovide')
  let g:neovide_cursor_animation_length = 0
  let g:neovide_cursor_short_animation_length = 0
  let g:neovide_position_animation_length = 0
  let g:neovide_scroll_animation_length = 0
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

" Right Click Context Menu (Copy-Cut-Paste)
if exists(':GuiShowContextMenu')
  nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
  inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
  xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
  snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv
endif

" Key Mappings
nnoremap <C-S-v> a<C-r>+<Esc>
nnoremap <D-v>   a<C-r>+<Esc>

inoremap <C-S-v> <C-r>+
inoremap <D-v>   <C-r>+

cnoremap <C-S-v> <C-r>+
cnoremap <D-v>   <C-r>+

noremap  <C-S-w> <Esc>:qa!<CR>
noremap  <D-w>   <Esc>:qa!<CR>

noremap! <C-S-w> <Esc>:qa!<CR>
noremap! <D-w>   <Esc>:qa!<CR>
