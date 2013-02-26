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

"Create a command for formatting the entire buffer
command! Autoformat call s:Autoformat()

"formatprg is a global option
"So when buffer/window/tab changes, 
"(re)load formatprg from the bufferlocal variable
au BufEnter,WinEnter * if exists("b:formatprg") | let &formatprg=b:formatprg

"Function for finding and setting the formatter 
"with the given name, if the formatter is installed
"globally or in the formatters folder
let s:formatprgvarname = "g:formatprg_".&filetype
if !exists(s:formatprgvarname)
	echo "No formatter set for this filetype"
	finish
endif
s:formatprg = eval(s:formatprgvarname)
s:formatprgname = matchstr(s:formatprg, '^[^ ]+')

"Check if given formatprg is installed
if executable(s:formatprgname)
	b:formatprg = s:formatprg
else
	let s:formatterdir = fnamemodify(expand("<sfile>"), ":h:h")."/formatters/"
	let s:formatprgname = s:formatterdir.s:formatprgname
	if executable(s:formatprgname)
		b:formatprg = s:formatprg
	endif
endif
