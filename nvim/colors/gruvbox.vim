highlight clear
if exists('syntax_on')
  syntax reset
en

" Functions {{{ X
fu! Hi(group, highlights)
    let s:hlstr = ''
    for [k, v] in items(a:highlights)
        let s:hlstr ..= k .. '=' .. v .. ' '
    endfo

    exe 'hi' a:group s:hlstr
endf

fu! Link(from, to)
    exe 'hi link' a:from a:to
endf
" }}}

" Setup {{{ X
let g:colors_name = 'gruvbox'

let s:cs = {
    \ 'bg': '#282828',
    \ 'black': '#5a524c',
    \ 'red': '#ea6962',
    \ 'green': '#a9b665',
    \ 'yellow':'#d8a657',
    \ 'blue': '#7daea3',
    \ 'purple': '#d3869b',
    \ 'cyan': '#89b482',
    \ 'white': '#d4be98',
    \ 'orange': '#e78a4e',
    \ 'grey': '#928374',
    \ 'light_grey': '#32302f',
    \ 'grey_white': '#45403d',
    \ 'hi': '#a89984'
    \ }

let g:terminal_ansi_colors = [
    \ s:cs.black,s:cs.red,s:cs.green,s:cs.yellow,s:cs.blue,s:cs.purple,s:cs.cyan,s:cs.white,
    \ s:cs.black,s:cs.red,s:cs.green,s:cs.yellow,s:cs.blue,s:cs.purple,s:cs.cyan,s:cs.white
    \ ]
" }}}

" Basic UI {{{
cal Hi('Normal', { 'guifg': s:cs.white, 'guibg': s:cs.bg })

cal Hi('ErrorMsg', { 'gui': 'bold,underline', 'guifg': s:cs.red, 'guibg': 'NONE' })

cal Hi('LineNr', { 'guifg': s:cs.black })
cal Hi('CursorLineNr', { 'gui': 'NONE', 'guifg': s:cs.grey })
cal Hi('CursorLine', { 'guibg': s:cs.light_grey })

cal Hi('ColorColumn', { 'guibg': s:cs.light_grey })
cal Hi('SignColumn', { 'guibg': s:cs.bg })
cal Hi('FoldColumn', { 'guibg': s:cs.bg })
cal Hi('Folded', { 'guifg': s:cs.grey, 'guibg': s:cs.light_grey })

cal Hi('VertSplit', { 'guifg': s:cs.black })
cal Hi('MatchParen', { 'guibg': s:cs.grey_white })

cal Hi('NormalFloat', { 'guibg': 'NONE' })
cal Hi('Visual', { 'guibg': s:cs.grey_white })
cal Hi('Whitespace', { 'guifg': s:cs.black })

cal Hi('Special', { 'guifg': s:cs.yellow })
cal Hi('Statement', { 'gui': 'italic', 'guifg': s:cs.red })
cal Hi('Identifier', { 'guifg': s:cs.blue })
" }}}

" Completion {{{ X

" Pmenu {{{ X
cal Hi('Pmenu', { 'guibg': s:cs.grey_white })
cal Hi('PmenuSel', { 'guifg': s:cs.grey_white, 'guibg': s:cs.hi })
cal Hi('PmenuSbar', { 'guibg': s:cs.grey_white })
cal Hi('PmenuThumb', { 'guibg': s:cs.hi })
" }}}

" nvim-cmp {{{ X
cal Hi('CmpItemAbbrMatch', { 'gui': 'bold', 'guifg': s:cs.green })
cal Hi('CmpItemAbbrMatchFuzzy', { 'gui': 'bold', 'guifg': s:cs.green })
" }}}

" }}}

" Nvim-tree {{{ X
cal Hi('NvimTreeIndentMarker', { 'guifg': s:cs.grey })
cal Hi('Directory', { 'guifg': s:cs.orange })
cal Link('Directory', 'NvimTreeFolderName')
" }}}

" LSP/Diagnostics {{{ X
cal Hi('DiagnosticError', { 'guifg': s:cs.red })
cal Hi('DiagnosticWarn', { 'guifg': s:cs.yellow })
cal Hi('DiagnosticHint', { 'guifg': s:cs.green })
cal Hi('DiagnosticInfo', { 'guifg': s:cs.blue })

cal Hi('DiagnosticUnderlineError', { 'gui': 'undercurl', 'guisp': s:cs.red })
cal Hi('DiagnosticUnderlineWarn', { 'gui': 'undercurl', 'guisp': s:cs.yellow })
cal Hi('DiagnosticUnderlineHint', { 'gui': 'undercurl', 'guisp': s:cs.green })
cal Hi('DiagnosticUnderlineInfo', { 'gui': 'undercurl', 'guisp': s:cs.blue })

for e in [ 'Error', 'Warn', 'Hint', 'Info' ]
  cal Link('Diagnostic' .. e, 'DiagnosticFloating' .. e)
  cal Link('Diagnostic' .. e, 'DiagnosticSign' .. e)
endfo
" }}}

" Diffs {{{ X
cal Hi('DiffAdd', { 'guibg': '#34381b' })
cal Hi('DiffChange', { 'guibg': '#0e363e' })
cal Hi('DiffDelete', { 'guibg': '#402120' })
" }}}

" Gitsigns {{{ X
cal Hi('GitSignsAdd', { 'guifg': s:cs.green })
cal Hi('GitSignsChange', { 'guifg': s:cs.blue })
cal Hi('GitSignsDelete', { 'guifg': s:cs.red })
" }}}

" Spelling {{{ X
cal Hi('SpellBad', { 'gui': 'undercurl', 'guisp': s:cs.red })
cal Hi('SpellRare', { 'gui': 'undercurl', 'guisp': s:cs.purple })
cal Hi('SpellCap', { 'gui': 'undercurl', 'guisp': s:cs.blue })
cal Hi('SpellLocal', { 'gui': 'undercurl', 'guisp': s:cs.cyan })
" }}}

" Treesitter {{{

" Comments {{{
cal Hi('Comment', { 'gui': 'italic', 'guifg': s:cs.grey })
cal Link('Comment', 'TSComment')
" }}}

" Booleans {{{ X
cal Hi('Boolean', { 'guifg': s:cs.cyan })
cal Link('Boolean', 'TSBoolean')
" }}}

" Constants {{{ X
cal Hi('Constant', { 'guifg': s:cs.white })
cal Link('Constant', 'TSConstant')
cal Hi('TSConstBuiltin', { 'guifg': s:cs.purple })
" }}}

" Strings {{{ X
cal Hi('String', { 'guifg': s:cs.yellow })
cal Link('String', 'TSString')
cal Hi('TSStringEscape', { 'guifg': s:cs.green })
" }}}

" Operators {{{ X
cal Hi('Operator', { 'guifg': s:cs.orange })
cal Link('Operator', 'TSOperator')
cal Link('Operator', 'TSKeywordOperator')
" }}}

" Types {{{ X
cal Hi('Type', { 'gui': 'NONE', 'guifg': s:cs.cyan })
cal Link('Type', 'TSType')
cal Hi('TSTypeBuiltin', { 'guifg': s:cs.blue })
" }}}

" Functions {{{ X
cal Hi('Function', { 'guifg': s:cs.green })
cal Link('Function', 'TSFunction')
cal Link('Function', 'TSMethod')
cal Hi('TSFuncBuiltin', { 'guifg': s:cs.green })
" }}}

" Macros {{{ X
cal Hi('Macro', { 'guifg': s:cs.green })
cal Link('Macro', 'TSFuncMacro')
cal Hi('TSConstMacro', { 'gui': 'italic', 'guifg': s:cs.red })
cal Hi('PreProc', { 'guifg': s:cs.purple })
" }}}

" Keywords {{{ X
cal Hi('Keyword', { 'gui': 'italic', 'guifg': s:cs.red })
cal Link('Keyword', 'TSKeywordFunction')
cal Hi('TSConditional', { 'gui': 'italic', 'guifg': s:cs.red })
cal Hi('TSRepeat', { 'gui': 'italic', 'guifg': s:cs.red })
" }}}

" Numbers {{{ X
cal Hi('Number', { 'guifg': s:cs.purple })
cal Link('Number', 'TSNumber')
" }}}

" Variables {{{ X
cal Hi('TSParameter', { 'guifg': s:cs.white })
cal Hi('TSVariable', { 'guifg': s:cs.white })
cal Hi('TSVariableBuiltin', { 'guifg': s:cs.purple })
" }}}

" Includes {{{ X
cal Hi('Include', { 'gui': 'italic', 'guifg': s:cs.red })
cal Link('Include', 'TSInclude')
" }}}

" Punctuation {{{ X
cal Hi('TSPunctDelimiter', { 'guifg': s:cs.grey })
cal Hi('TSPunctBracket', { 'guifg': s:cs.white })
" }}}

" Fields {{{ X
cal Hi('TSProperty', { 'guifg': s:cs.white })
cal Hi('TSField', { 'guifg': s:cs.white })
" }}}

" Misc {{{
cal Hi('TSConstructor', { 'guifg': s:cs.cyan })
cal Hi('TSNamespace', { 'guifg': s:cs.cyan })
" }}}

" }}}

" Language-specific highlights {{{

" C/C++ {{{
cal Hi('cTSType', { 'guifg': s:cs.blue })
cal Hi('cppTSType', { 'guifg': s:cs.blue })
cal Hi('cTSBoolean', { 'guifg': s:cs.purple })
cal Hi('cppTSBoolean', { 'guifg': s:cs.purple })
" }}}

" Lua {{{
cal Hi('TSLocal', { 'guifg': s:cs.red })
cal Hi('luaTSConstructor', { 'guifg': s:cs.white })
cal Hi('luaTSConstBuiltin', { 'guifg': s:cs.cyan })
" }}}

" Python {{{
cal Hi('pythonTSConstructor', { 'guifg': s:cs.green })
cal Hi('pythonTSInclude', { 'gui': 'italic', 'guifg': s:cs.purple })
" }}}

" Type/Javascript {{{
cal Hi('TSDeclaration', { 'guifg': s:cs.orange })
cal Hi('javascriptTSBoolean', { 'guifg': s:cs.purple })
cal Hi('typescriptTSBoolean', { 'guifg': s:cs.purple })
cal Hi('typescriptTSKeywordOperator', { 'gui': 'italic', 'guifg': s:cs.red })
cal Hi('javascriptTSKeywordOperator', { 'gui': 'italic', 'guifg': s:cs.red })
cal Hi('typescriptTSInclude', { 'gui': 'italic', 'guifg': s:cs.purple })
cal Hi('javascriptTSInclude', { 'gui': 'italic', 'guifg': s:cs.purple })
" }}}

" sh {{{
cal Hi('bashTSPunctSpecial', { 'guifg': s:cs.purple })
cal Hi('zshFunction', { 'guifg': s:cs.green })
cal Hi('zshOperator', { 'guifg': s:cs.orange })
" }}}

" }}}

" Links {{{
" highlight! link CursorColumn ColorColumn
" highlight! link CursorLine ColorColumn
" highlight! link DiffAdded DiffAdd
" highlight! link DiffRemoved DiffDelete
" highlight! link EndOfBuffer Whitespace
" highlight! link FoldColumn LineNr
" highlight! link LspDiagnosticsDefaultError DiagnosticError
" highlight! link LspDiagnosticsDefaultHint DiagnosticHint
" highlight! link LspDiagnosticsDefaultInformation DiagnosticInfo
" highlight! link LspDiagnosticsDefaultWarning DiagnosticWarn
" highlight! link LspReferenceRead Visual
" highlight! link LspReferenceText Visual
" highlight! link LspReferenceWrite Visual
" highlight! link NonText Whitespace
" highlight! link Pmenu NormalFloat
" highlight! link PmenuSbar Pmenu
" highlight! link PmenuThumb PmenuSel
" highlight! link Question MoreMsg
" highlight! link SignColumn LineNr
" highlight! link SignifySignAdd GitSignsAdd
" highlight! link SignifySignChange GitSignsChange
" highlight! link SignifySignDelete GitSignsDelete
" highlight! link SpecialKey Whitespace
" highlight! link StatusLine NormalFloat
" highlight! link TSConstMacro Constant
" highlight! link TSEmphasis Italic
" highlight! link TSEnvironment Statement
" highlight! link TSEnvironmentName PreProc
" highlight! link TSFuncBuiltin Function
" highlight! link TSFuncMacro Function
" highlight! link TSKeywordFunction PreProc
" highlight! link TSUnderline Underlined
" highlight! link TSVariable Identifier
" }}}

" vim: set sw=2 fdm=marker fmr={{{,}}}:
