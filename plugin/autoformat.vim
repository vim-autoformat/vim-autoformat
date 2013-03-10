"Function for formatting the entire buffer
function! s:Autoformat()
	"If a formatprg is specified
	if &formatprg!=""
	  	"Save window state
	  	let winview=winsaveview()
		"Autoformat code
		silent exe "normal gggqG"
		"Recall window state
	  	call winrestview(winview)
	else 
	    let s:formatprg_var = "g:formatprg_".&filetype
        if !exists(s:formatprg_var)
		    echo "No formatter defined for filetype ".&filetype."."
        else
            echo "Defined formatter ".eval(s:formatprg_var)." is not executable."
        endif
        echo "Using indent file instead."
        "Autoindent code
        silent exe "normal gg=G"
	endif
endfunction

"Create a command for formatting the entire buffer
command! Autoformat call s:Autoformat()

"Function for finding and setting the formatter 
"with the given name, if the formatter is installed
"globally or in the formatters folder
let s:formatterdir = fnamemodify(expand("<sfile>"), ":p:h:h")."/formatters/"
function! s:set_formatprg()
	"Reset previous formatprg
	set formatprg=""

	"Get formatprg config for current filetype
	let s:formatprg_var = "g:formatprg_".&filetype
	let s:formatprg_args_var = "g:formatprg_args_".&filetype

	if !exists(s:formatprg_var)
		"No formatprg defined
		return
	endif
	let s:formatprg = eval(s:formatprg_var)

    let s:formatprg_args = ""
    if  exists(s:formatprg_args_var)
        let s:formatprg_args = eval(s:formatprg_args_var)
    endif
	
	"Set correct formatprg path, if it is installed
	if !executable(s:formatprg)
		let s:formatprg = s:formatterdir.s:formatprg
		if !executable(s:formatprg)
			"Configured formatprg not installed
			return
		endif
	endif
	let b:formatprg = s:formatprg." ".s:formatprg_args
endfunction

"When filetype changes, set correct b:formatprg
au FileType * call s:set_formatprg()

"When current buffer changes, store b:formatprg into &formatprg
au BufEnter * if exists("b:formatprg") | let &formatprg = b:formatprg
