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

"Set indenting behaviour to match with the formatter
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
