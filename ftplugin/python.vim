"Set the formatter name and arguments for this filetype
let s:prgname   = "autopep8"
let s:arguments = "/dev/stdin"

"Set the formatprg option, if the formatter is installed
"globally or in the formatters folder
call g:FindFormatter(s:prgname, s:arguments)
