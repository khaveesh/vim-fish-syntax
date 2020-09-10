setlocal comments=:#
setlocal commentstring=#%s
setlocal define=\\v^\\s*function>
setlocal formatoptions+=ron1
setlocal formatoptions-=t
setlocal include=\\v^\\s*\\.>
setlocal suffixesadd^=.fish

" Use the 'j' format option when available.
if v:version ># 703 || v:version ==# 703 && has('patch541')
	setlocal formatoptions+=j
endif

let b:match_words =
			\ escape('<%(begin|function|if|switch|while|for)>:<end>', '<>%|)')
