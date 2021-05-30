function! fish#Fold()
    let l:line = getline(v:lnum)
    if l:line =~# '\v^\s*%(begin|if|while|for|function|switch)>'
        return 'a1'
    elseif l:line =~# '\v^\s*end>'
        return 's1'
    else
        return '='
    end
endfunction

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
        let l:sufpos = match(a:base, '\v\S+$')
        if l:sufpos >= 0
            let l:cmd = a:base[:l:sufpos-1]
            let l:arg = a:base[l:sufpos:]
        else
            let l:cmd = a:base
            let l:arg = ''
        endif
        for l:line in filter(split(l:completions, '\n'), '!empty(v:val)')
            let l:tokens = split(l:line, '\t')
            let l:term = l:tokens[0]
            if l:term =~? '^\V'.l:arg
                call add(l:results, {
                            \ 'word': l:cmd.l:term,
                            \ 'abbr': l:term,
                            \ 'menu': get(l:tokens, 1, ''),
                            \ 'dup': 1
                            \ })
            endif
        endfor
        return l:results
    endif
endfunction

function! fish#Help(ref) abort
    let l:ref = a:ref
    if empty(a:ref)
        " let l:ref = &filetype ==# 'man' ? expand('<cWORD>') : expand('<cword>')
        let l:ref = expand('<cword>')
        if empty(l:ref)
            call s:fish_help_error('no identifier under cursor')
            return
        endif
    endif
    let l:output = systemlist('fish -c "man -w ' . shellescape(l:ref) . '"')
    if v:shell_error
        call s:fish_help_error(printf('command exited with code %d: %s', v:shell_error, join(l:output)))
        return
    endif
    aug ft_man_fish
        au FileType man
          \ setlocal nobuflisted
          \ | setlocal keywordprg=:FishHelp'
          \ | nnoremap <silent> <buffer> K :FishHelp<cr>
          \ | nnoremap <silent> <buffer> <C-]> :FishHelp<cr>
    aug END
    execute 'Man ' . l:output[0]
    silent aug! ft_man_fish
endfunction

function! s:fish_help_error(message)
    echohl ErrorMsg
    echon 'FishHelp: ' a:message
    echohl NONE
endfunction
