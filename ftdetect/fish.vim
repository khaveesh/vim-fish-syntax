au BufNewFile,BufRead *.fish setfiletype fish

autocmd BufNewFile,BufRead,StdinReadPost *
			\ if getline(1) =~ '^#!.*\Wfish\s*$' |
			\   setfiletype fish |
			\ endif
