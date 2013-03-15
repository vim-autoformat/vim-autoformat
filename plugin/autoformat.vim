"Function for finding and setting the formatter 
"with the given name, if the formatter is installed
"globally or in the formatters folder
let s:formatterdir = fnamemodify(expand("<sfile>"), ":p:h:h")."/formatters/"
function! g:set_formatprg()
    "Reset previous formatprg
    set formatprg=""

    "Get formatprg config for current filetype
    let s:formatprg_var = "g:formatprg_".&filetype
    let s:formatprg_args_var = "g:formatprg_args_".&filetype
    let s:formatprg_args_expr_var = "g:formatprg_args_expr_".&filetype

    if !exists(s:formatprg_var)
        "No formatprg defined
        return
    endif
    let s:formatprg = eval(s:formatprg_var)

    let s:formatprg_args = ""
    if  exists(s:formatprg_args_var)
        let s:formatprg_args = eval(eval(s:formatprg_args_var))
    endif

    "Set correct formatprg path, if it is installed
    if !executable(s:formatprg)
        let s:formatprg = s:formatterdir.s:formatprg
        if !executable(s:formatprg)
            "Configured formatprg not installed
            return
        endif
    endif
    let &formatprg = s:formatprg." ".s:formatprg_args
    return &formatprg!=""
endfunction

"function! s:gq(mode)
"    call g:set_formatprg()
"
"    if &formatprg!=""
"        echo "Using formatprg"
"        "Autoformat code
"        exe a:mode." gq"
"    else 
"        echo "Using indentfile"
"        "Autoindent code
"        exe a:mode." ="
"    endif
"endfunction

"When gq has been pressed:
"1. set right formatprg
"2. if formatprg!="" run regular gq
"3. else run =

"if(!g:set_formatprg()) | nnoremap gq = | endif
"nnoremap gq if(g:set_formatprg()) | gq | else | =
"nnoremap <expr> gq g:set_formatprg() ? gq : =
"noremap gq :call g:set_formatprg()<cr>gq
"nnoremap gq :call <SID>gq("normal")<cr>
"vnoremap gq :call <SID>gq("visual")<cr>


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
            echo "No formatter defined for filetype '".&filetype."'."
        else
            echo "Defined formatter ".eval(s:formatprg_var)." is not executable."
        endif
        echo "Using indent file instead."
        "Save window state
        let winview=winsaveview()
        "Autoindent code
        silent exe "normal gg=G"
        "Recall window state
        call winrestview(winview)
    endif
endfunction

"Create a command for formatting the entire buffer
command! Autoformat call s:Autoformat()
