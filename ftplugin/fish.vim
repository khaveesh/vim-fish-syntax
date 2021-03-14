if exists('b:did_ftplugin')
    finish
end
let b:did_ftplugin = 1

let s:save_cpo = &cpo
set cpo&vim

setlocal comments=:#
setlocal commentstring=#%s
setlocal define=\\v^\\s*function>
setlocal formatoptions+=n1
setlocal formatoptions-=t
setlocal include=\\v^\\s*\\.>
setlocal iskeyword=@,48-57,+,-,_,.
setlocal suffixesadd^=.fish

" Use the 'j' format option when available.
if v:version ># 703 || v:version ==# 703 && has('patch541')
    setlocal formatoptions+=j
endif

if executable('fish')
    setlocal omnifunc=fish#Complete
endif

let b:match_ignorecase = 0
if has('patch-7.3.1037')
    let s:if = '%(else\s\+)\@15<!if'
else
    let s:if = '%(else\s\+)\@<!if'
endif

let b:match_words = escape(
            \'<%(begin|function|'.s:if.'|switch|while|for)>:<else\s\+if|case>:<else>:<end>'
            \, '<>%|)')
let b:match_skip = 's:comment\|string\|deref'


let b:undo_ftplugin = "
            \ setlocal comments< commentstring< define< foldexpr< formatoptions<
            \|setlocal include< iskeyword< suffixesadd<
            \|setlocal formatexpr< omnifunc< path< keywordprg<
            \|unlet! b:match_words
            \"

let &cpo = s:save_cpo
unlet s:save_cpo
