"Function for finding and setting the formatter with the given name
function! s:set_formatprg(...)
    let type = a:0 ? a:1 : &filetype

    "Get formatprg config
    let s:formatprg_var = "g:formatprg_".type
    let s:formatprg_args_var = "g:formatprg_args_".type
    let s:formatprg_args_expr_var = "g:formatprg_args_expr_".type

    if !exists(s:formatprg_var)
        "No formatprg defined
        if exists("g:autoformat_verbosemode")
            echoerr "No formatter defined for filetype '".type."'."
        endif
        return 0
    endif
    let s:formatprg = eval(s:formatprg_var)

    let s:formatprg_args = ""
    if  exists(s:formatprg_args_expr_var)
        let s:formatprg_args = eval(eval(s:formatprg_args_expr_var))
    elseif exists(s:formatprg_args_var)
        let s:formatprg_args = eval(s:formatprg_args_var)
    endif

    "Set correct formatprg path, if it is installed
    if !executable(s:formatprg)
        "Configured formatprg not installed
        if exists("g:autoformat_verbosemode")
            echoerr "Defined formatter ".eval(s:formatprg_var)." is not executable."
        endif
        return 0
    endif
    let &formatprg = s:formatprg." ".s:formatprg_args

    return 1
endfunction

"set right formatprg before formatting
noremap <expr> gq <SID>set_formatprg() ? 'gq' : 'gq'

"Function for formatting the entire buffer
function! s:Autoformat(...)
    "Save window state
    let winview=winsaveview()

    if call('<SID>set_formatprg', a:000)
        "Autoformat code
        exe "1,$!".&formatprg
    else
        "Autoindent code
        exe "normal gg=G"
    endif

    "Recall window state
    call winrestview(winview)
endfunction

"Create a command for formatting the entire buffer
command! -nargs=? -complete=filetype Autoformat call s:Autoformat(<f-args>)
