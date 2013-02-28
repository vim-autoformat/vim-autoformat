if exists("b:formatprg_set")
	finish
endif
let b:formatprg_set = 1

"Set the formatter name and arguments for this filetype
let s:prgname   = "tidy"
let s:arguments = "-q --show-errors 0 --show-warnings 0 --indent auto --indent-spaces 2 --vertical-space yes --tidy-mark no --wrap 68"

"Set the formatprg option, if the formatter is installed
"globally or in the formatters/ folder
call g:FindFormatter(s:prgname, s:arguments)

"Set indenting behaviour to match with the formatter
set expandtab
set tabstop=2
set shiftwidth=2
