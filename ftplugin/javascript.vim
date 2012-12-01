let s:bundleDir = fnamemodify(expand("<sfile>"), ":h:h:h")
let s:prgpath   = s:bundleDir."/js-beautify/python/js-beautify"
let s:arguments = "-i"

if executable(s:prgpath)
	let &formatprg=s:prgpath." ".s:arguments
endif

set expandtab
set tabstop=4
set shiftwidth=4
