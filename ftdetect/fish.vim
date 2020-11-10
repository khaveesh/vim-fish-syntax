au BufNewFile,BufRead *.fish setf fish

autocmd BufNewFile,BufRead,StdinReadPost *
			\ if getline(1) =~ '^#!.*\Wfish\s*$' |
			\   setf fish |
			\ endif
