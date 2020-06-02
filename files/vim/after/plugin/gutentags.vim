" gutentags.vim - plugin configuration

" Manage all tags under a cache directory, creating it as needed:
let g:gutentags_cache_dir = $HOME . '/.cache/gutentags'

if !isdirectory(g:gutentags_cache_dir)
  call mkdir(g:gutentags_cache_dir, 'p')
endif

" g:gutentags_file_list_command may be a string or dictionary and must
" be removed prior to assignment to avoid errors on older vim releases:
unlet g:gutentags_file_list_command

" Restrict tag generation to only files tracked in the repository;
" see: gutentags_file_list_command.
let g:gutentags_file_list_command = {
      \ 'markers': {
      \   '.git': 'git ls-files --cached --others',
      \   '.hg':  'hg files',
      \ },
      \ }
