if exists("b:formatprg_set")
	finish
endif
let b:formatprg_set = 1

"Besides installing the js-beautify globally or in the 
"formatters/ folder, installing as a vim bundle is supported.
let s:prgname	= "js-beautify"
let s:arguments = "-i"

let s:bundleDir = fnamemodify(expand("<sfile>"), ":h:h:h")
let s:prgpath   = s:bundleDir."/js-beautify/python/".s:prgname

if executable(s:prgpath)
	"If js-beautify is installed as a bundle
	let b:formatprg=s:prgpath." ".s:arguments
else
	"Else look for js-beautify globally
	"or in the formatters/ folder
	call g:FindFormatter(s:prgname,s:arguments)
endif

let b:autoformat = 1
"Enable on-the-fly formatting
if b:autoformat==1 
	"inoremap <CR> <C-O>gqq<CR>
	"inoremap } }<C-O>gq%
endif

"Set indenting behaviour to match with the formatter
set expandtab
set tabstop=4
set shiftwidth=4
