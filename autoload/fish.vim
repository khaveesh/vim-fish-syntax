function! fish#Complete(findstart, base) abort
    if a:findstart
        return getline('.') =~# '\v^\s*$' ? -1 : 0
    else
        if empty(a:base)
            return []
        endif
        let l:results = []
        let l:completions =
                    \ system('fish -c "complete -C'.shellescape(a:base).'"')
        let l:cmd = substitute(a:base, '\v\S+$', '', '')
        for l:line in filter(split(l:completions, '\n'), 'len(v:val)')
            let l:tokens = split(l:line, '\t')
            call add(l:results, {'word': l:cmd.l:tokens[0],
                                \'abbr': l:tokens[0],
                                \'menu': get(l:tokens, 1, '')})
        endfor
        return l:results
    endif
endfunction
