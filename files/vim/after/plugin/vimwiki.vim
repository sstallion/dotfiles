" vimwiki.vim - plugin configuration

" Configure default Vimwiki instance (if it exists) and update global
" behavior for Markdown sources:
if !exists('g:vimwiki_list')
  let g:vimwiki_list = []
endif
if !empty(glob('~/.vimwiki'))
  let s:vimwiki_exclude_files = [
        \ 'README.md',
        \ 'links.md',
        \ 'navigation.md',
        \ 'tags.md',
        \ ]

  let g:vimwiki_list = [
        \ {'path': '~/.vimwiki', 'syntax': 'markdown', 'ext': '.md',
        \  'auto_diary_index': 1, 'auto_generate_links': 1,
        \  'auto_generate_tags': 1, 'auto_tags': 1, 'auto_toc': 1,
        \  'exclude_files': s:vimwiki_exclude_files, 'list_margin': 0,
        \ }] + g:vimwiki_list
endif

" Disable text concealing:
let g:vimwiki_conceallevel = 0

" Disable creating links by default:
let g:vimwiki_create_link = 0

" Disable creation of temporary wikis:
let g:vimwiki_global_ext = 0

" Append file extension to wiki links:
let g:vimwiki_markdown_link_ext = 1

" Place TOC after title header:
let g:vimwiki_toc_header_level = 2

" Reinitialize Vimwiki settings; (see vimwiki-options).
call vimwiki#vars#init()
