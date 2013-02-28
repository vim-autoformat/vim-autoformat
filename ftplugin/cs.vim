if exists("b:formatprg_set")
	finish
endif
let b:formatprg_set = 1

"Set the formatter name and arguments for this filetype
let s:prgname   = "astyle"
let s:arguments = "--mode=cs --style=ansi"

"Set the formatprg option, if the formatter is installed
"globally or in the formatters/ folder
call g:FindFormatter(s:prgname, s:arguments)
