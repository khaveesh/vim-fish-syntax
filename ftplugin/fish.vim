if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpo
set cpo&vim

setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
setlocal comments=:#
setlocal commentstring=#%s
setlocal define=\\v^\\s*function>
setlocal foldexpr=fish#Fold()
setlocal formatoptions+=jn1
setlocal formatoptions-=t
setlocal include=\\v^\\s*\\.>
setlocal iskeyword=@,48-57,+,-,_,.
setlocal suffixesadd^=.fish

if executable('fish')
  setlocal omnifunc=fish#Complete
  setlocal formatprg=fish_indent
  let b:formatprg = [ 'fish_indent' ]
endif

let b:match_ignorecase = 0
let b:match_words = escape(
      \ '<%(begin|function|%(else\s\+)\@15<!if|switch|while|for)>'
        \   . ':<else\s\+if|case>:<else>:<end>',
        \ '<>%|)')
let b:match_skip = 's:comment\|string\|deref'

let b:undo_ftplugin = "
      \ setlocal comments< commentstring< define< foldexpr< formatoptions<
      \ | setlocal include< iskeyword< suffixesadd< omnifunc< formatprg<
      \ | unlet! b:match_words b:match_skip b:match_ignorecase
      \"

let &cpo = s:save_cpo
unlet s:save_cpo
