autocmd BufNewFile,BufRead *.fish setfiletype fish

" Detect fish scripts by the shebang line.
autocmd BufNewFile,BufRead,StdinReadPost *
            \ if getline(1) =~ '^#!.*\Wfish\s*$' |
            \     setfiletype fish |
            \ endif
