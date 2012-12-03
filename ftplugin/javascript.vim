"Besides installing the js-beautify globally or in the 
"formatters/ folder, cloning the repository as a vim bundle
"is supported as well.
let s:prgname	= "js-beautify"
let s:arguments = "-i"

let s:bundleDir = fnamemodify(expand("<sfile>"), ":h:h:h")
let s:prgpath   = s:bundleDir."/js-beautify/python/".s:prgname

if executable(s:prgpath)
	"If js-beautify is installed as a bundle
	let &formatprg=s:prgpath." ".s:arguments
else
	"Else look for js-beautify globally
	"or in the formatters/folder
	call g:FindFormatter(s:prgname,s:arguments)
endif

"Set indenting behaviour to match with the formatter
set expandtab
set tabstop=4
set shiftwidth=4
