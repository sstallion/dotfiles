" grepper.vim - plugin configuration

" Use location list for matches:
let g:grepper.quickfix = 0

" Search repo before falling back to directory of buffer:
let g:grepper.dir = 'repo,filecwd'

" Configure tools to search; prefer greplikes over git:
let g:grepper.tools = ['rg', 'grep', 'git']

" Support queries that begin with dashes by default:
let g:grepper.rg.grepprg .= ' --'
let g:grepper.grep.grepprg .= ' --'
let g:grepper.git.grepprg .= ' --'

" Mimic command-line in prompt;
let g:grepper.prompt_text = '$c '

" Update search history after query:
let g:grepper.searchreg = 1
