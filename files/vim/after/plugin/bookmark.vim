" bookmark.vim - plugin configuration

" Prefer Location List to QuickFix List for bookmarks;
" see: https://github.com/MattesGroeger/vim-bookmarks/pull/97.
let g:bookmark_location_list = 1

" Key Mappings
nmap <silent> <Leader>m <Plug>BookmarkShowAll
nmap <silent> [m        <Plug>BookmarkPrev
nmap <silent> ]m        <Plug>BookmarkNext
