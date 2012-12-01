let s:prgpath   = "autopep8"
let s:arguments = " /dev/stdin"
if executable(s:prgpath)
	let &formatprg=s:prgpath." ".s:arguments
endif
