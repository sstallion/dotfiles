" lightline.vim - plugin configuration

" Disable lightline if using a limited terminal:
if !has('gui_running') && &t_Co < 256
  let g:lightline = {
        \ 'enable': {
        \   'statusline': 0,
        \   'tabline'   : 0,
        \ },
        \ }
  finish
endif

" Disable showmode if lightline is enabled:
set noshowmode

" Returns a modified {bufname} according to {mods}, normalizing
" directory names. Long paths are shortened to prevent collapsing.
function! s:bufnamemodify(bufnr, mods, bufname)
  let fname = expand(printf('#%d:p', a:bufnr))
  if empty(glob(fname))
    return a:bufname  " return bufname if not a file
  endif
  let bufname = fnamemodify(fname, printf(':s?%s$??%s', expand('/'), a:mods))
  if bufexists(a:bufnr)
    let winwidth = winwidth(bufwinnr(a:bufnr)) / 2
    if winwidth > 0 && winwidth < len(bufname)
      " pathshorten() isn't particularly useful here; improvise:
      let bufname = printf('…%s%s', expand('/'), fnamemodify(bufname, ':t'))
    endif
  endif
  return printf('%s%s', bufname, isdirectory(fname) ? expand('/') : '')
endfunction

" Returns name of buffer identified by {bufnr} modified according to
" {mods}. Buffer names are extracted using the :ls command rather than
" bufname() as the latter does not work reliably with all buffer types.
function! s:getbufname(bufnr, mods)
  redir => buffers
    silent ls!
  redir END
  for line in split(buffers, '\n')
    if match(line, printf('^\s*%d\D', a:bufnr)) != -1
      let bufname = substitute(line, '^.*"\(.\{-}\)".*$', '\1', '')
      return s:bufnamemodify(a:bufnr, a:mods, bufname)
    endif
  endfor
  return '[No Name]'
endfunction

" Returns filename for buffer identified by {bufnr} suitable for display
" in the statusline or tabline.
function! s:getfilename(bufnr, mods, readonly, modifiable, modified)
  return  (a:readonly ? ' ' : '') . s:getbufname(a:bufnr, a:mods) .
        \ (!a:modifiable ? ' [-]' : (a:modified ? ' [+]' : ''))
endfunction

let g:lightline = {
      \ 'active': {
      \   'left' : [['mode', 'paste', 'search', 'spell'], ['fugitive'], ['filename']],
      \   'right': [['lineinfo'], ['percent'], ['fileformat']],
      \ },
      \ 'tab': {
      \   'active'  : ['tabnum', 'filename'],
      \   'inactive': ['tabnum', 'filename'],
      \ },
      \ 'component': {
      \   'paste'   : '%{&paste    ? "PASTE"  : ""}',
      \   'search'  : '%{&hlsearch ? "SEARCH" : ""}',
      \   'spell'   : '%{&spell    ? "SPELL"  : ""}',
      \   'lineinfo': ' %3l:%-2v',
      \ },
      \ 'component_visible_condition': {
      \   'paste' : '&paste',
      \   'search': '&hlsearch',
      \   'spell' : '&spell',
      \ },
      \ 'component_function': {
      \   'filename'  : 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'fugitive'  : 'LightLineFugitive',
      \ },
      \ 'tab_component_function': {
      \   'filename': 'LightLineTabFilename',
      \ },
      \ 'mode_map': {
      \   'c'     : 'NORMAL',
      \   'V'     : 'VISUAL',
      \   "\<C-v>": 'VISUAL',
      \   'S'     : 'SELECT',
      \   "\<C-s>": 'SELECT',
      \ },
      \ 'colorscheme' : 'wtf',
      \ 'separator'   : {'left': '', 'right': ''},
      \ 'subseparator': {'left': '', 'right': ''},
      \ }

function! LightLineFilename()
  let winnr = winnr()
  return s:getfilename(
        \ winbufnr(winnr),
        \ ':~:.',
        \ getwinvar(winnr, '&readonly'),
        \ getwinvar(winnr, '&modifiable'),
        \ getwinvar(winnr, '&modified'))
endfunction

function! LightLineTabFilename(n)
  let winnr = tabpagewinnr(a:n)
  return s:getfilename(
        \ tabpagebuflist(a:n)[winnr - 1],
        \ ':t',
        \ gettabwinvar(a:n, winnr, '&readonly'),
        \ gettabwinvar(a:n, winnr, '&modifiable'),
        \ gettabwinvar(a:n, winnr, '&modified'))
endfunction

function! LightLineFileformat()
  if has('unix')
    let showformat = &fileformat !=# 'unix'
  elseif has('win32')
    let showformat = &fileformat !=# 'dos'
  else
    let showformat = 1
  endif
  return showformat ? printf('[%s]', &fileformat) : ''
endfunction

function! LightLineFugitive()
  let branch = FugitiveHead(7)
  if !empty(branch)
    return printf(' %s', branch)
  endif
  return ''
endfunction

" lightline incorrectly calculates the width of the window when a
" vertical split is present, which results in improper highlighting;
" see: https://github.com/itchyny/lightline.vim/issues/179.
call lightline#colorscheme#wtf#highlight()

" Work around nested event issues when opening directories in netrw;
" see: https://github.com/itchyny/lightline.vim/issues/390.
augroup netrw_init
  autocmd!
  autocmd FileType netrw call lightline#enable()
augroup END
