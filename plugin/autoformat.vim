"Function for formatting the entire buffer
function! s:Autoformat()
	"If a formatprg is specified
	if &formatprg!=""
	  	"Save window state
	  	let winview=winsaveview()
		"Autoformat code
		:silent exe "normal gggqG"
		"Recall window state
	  	call winrestview(winview)
	else 
		echo "No formatter installed for this filetype"
	endif
endfunction

"Create a command for this
command! Autoformat call s:Autoformat()

"Function for finding and setting the formatter 
"with the given name, if the formatter is installed
"globally or in the formatters folder
let s:formatterdir = fnamemodify(expand("<sfile>"), ":h:h")."/formatters/"
function! g:FindFormatter(name, args)
	if executable(a:name)
		let s:prgpath = a:name
	else
		let s:bars = expand("<sfile>")
		let s:prgpath = s:formatterdir.a:name
	endif
	
	if executable(s:prgpath)
		let &formatprg=s:prgpath." ".a:args
	endif
endfunction

