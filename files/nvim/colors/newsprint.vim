" newsprint.vim - a (pleasant) monochromatic color scheme for Vim
" Last Change:  2010 Oct 21
" Maintainer:   Steven Stallion <sstallion@gmail.com>
" License:      Simplified BSD License

set background=light
highlight clear
if has('syntax')
  syntax reset
endif
let g:colors_name = 'newsprint'

" Console Colors
highlight Comment ctermfg=gray
highlight Constant ctermfg=black
highlight CursorLine ctermbg=gray
highlight Error ctermfg=gray ctermbg=black cterm=bold
highlight Identifier ctermfg=black cterm=bold
highlight Normal ctermfg=black
highlight PreProc ctermfg=black
highlight Special ctermfg=black cterm=bold
highlight Statement ctermfg=black cterm=bold,underline
highlight Type ctermfg=black cterm=bold
highlight Visual ctermfg=black ctermbg=gray

" GUI Colors
highlight Comment guifg=gray
highlight Constant guifg=gray gui=bold
highlight Cursor guibg=black
highlight CursorLine guibg=gray
highlight Error guifg=gray guibg=black gui=bold
highlight Identifier guifg=black gui=bold
highlight Normal guifg=black
highlight PreProc guifg=black gui=italic
highlight Special guifg=black gui=bold
highlight Statement guifg=black gui=bold,underline
highlight Type guifg=black gui=bold
highlight Visual guifg=black guibg=gray

" Links
highlight! link Search Visual
highlight! link NonText Normal
highlight! link Macro PreProc
highlight! link Boolean Constant
highlight! link Character Constant
highlight! link Conditional Statement
highlight! link CursorColumn CursorLine
highlight! link Debug PreProc
highlight! link Define PreProc
highlight! link Delimiter Identifier
highlight! link Directory Statement
highlight! link ErrorMsg Error
highlight! link Exception Statement
highlight! link Float Constant
highlight! link FoldColumn Folded
highlight! link Function Identifier
highlight! link Ignore Comment
highlight! link Include PreProc
highlight! link IncSearch Search
highlight! link Keyword Identifier
highlight! link Label Statement
highlight! link LineNr Comment
highlight! link MatchParen Statement
highlight! link MoreMsg Identifier
highlight! link NonText Comment
highlight! link Number Constant
highlight! link Operator Identifier
highlight! link Question MoreMsg
highlight! link PreCondit PreProc
highlight! link Repeat Statement
highlight! link SignColumn Identifier
highlight! link SpecialChar Special
highlight! link SpecialComment Special
highlight! link SpecialKey Special
highlight! link SpellBad Error
highlight! link SpellCap Error
highlight! link SpellLocal Error
highlight! link SpellRare Error
highlight! link StorageClass Type
highlight! link String Constant
highlight! link Structure Type
highlight! link Title Structure
highlight! link Todo Error
highlight! link Typedef Type
highlight! link WarningMsg Error
