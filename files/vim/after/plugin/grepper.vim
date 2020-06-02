" grepper.vim - plugin configuration

" Use location list for matches:
let g:grepper.quickfix = 0

" Search repo before falling back to directory of buffer:
let g:grepper.dir = 'repo,filecwd'

" Configure tools to search; prefer greplikes over git:
let g:grepper.tools = ['rg', 'grep', 'git']

" Mimic tool command-line in prompt;
" see: https://github.com/mhinz/vim-grepper/pull/194
let g:grepper.prompt_suffix = ''

" Key Mappings
nnoremap <Leader>g :Grepper<CR>
