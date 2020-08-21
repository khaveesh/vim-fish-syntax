au BufNewFile,BufRead *.fish set ft=fish

autocmd BufNewFile,BufRead,StdinReadPost *
    \ if getline(1) =~ '^#!.*\Wfish\s*$' |
    \   set ft=fish |
    \ endif
