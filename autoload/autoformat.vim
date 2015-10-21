function! autoformat#formatexpr()
  " Use Vim's internal method for autoformatting.
  " if v:char != '' || index(['i', 'R'], mode()) != -1
  if v:char != ''
    return 1
  endif

  let winview=winsaveview()
  exe v:lnum.";+".(v:count-1).' call autoformat#TryAllFormatters()'
  call winrestview(winview)
  return 0
endfunction


" Try all formatters, starting with the currently selected one, until one
" works. If none works, autoindent the buffer.
function! autoformat#TryAllFormatters(...) range
    " Make sure formatters are defined and detected
    if !call('autoformat#find_formatters', a:000)
        " No formatters defined, so autoindent code.
        exe a:firstline . "normal! =" . (a:lastline - a:firstline) . "j"
        return 0
    endif

    " Make sure index exists and is valid.
    if !exists('b:current_formatter_index')
        let b:current_formatter_index = 0
    endif
    if b:current_formatter_index >= len(b:formatters)
        let b:current_formatter_index = 0
    endif

    " Try all formatters, starting with selected one
    let s:index = b:current_formatter_index

    let verbose = &verbose || exists("g:autoformat_verbosemode")
    while 1
        let formatdef_var = 'g:formatdef_'.b:formatters[s:index]
        " Formatter definition must be existent
        if !exists(formatdef_var)
            echoerr "No format definition found in '".formatdef_var."'."
            return 0
        endif

        " Eval twice, once for getting definition content,
        " once for getting the final expression
        let formatter = eval(eval(formatdef_var))

        if verbose
          echom "autoformat: calling:" formatter
        endif
        exe '% !'.formatter

        if v:shell_error == 0
            return 1
        else
            undo
            let s:index = (s:index + 1) % len(b:formatters)
        endif

        if s:index == b:current_formatter_index
            " Tried all formatters, none worked so autoindent code.
            exe a:firstline . "normal! =" . (a:lastline - a:firstline) . "j"
            return 0
        endif
    endwhile

endfunction


" Function for finding the formatters for this filetype
" Result is stored in b:formatters
function! autoformat#find_formatters(...)
    " Detect verbosity
    let verbose = &verbose || exists("g:autoformat_verbosemode")

    " Extract filetype to be used
    let ftype = a:0 ? a:1 : &filetype
    " Support composite filetypes by replacing dots with underscores
    let compoundtype = substitute(ftype, "[.]", "_", "g")
    if ftype =~ "[.]"
        " Try all super filetypes in search for formatters in a sane order
        let ftypes = [compoundtype] + split(ftype, "[.]")
    else
        let ftypes = [compoundtype]
    endif

    " Warn for backward incompatible configuration
    let old_formatprg_var = "g:formatprg_".compoundtype
    let old_formatprg_args_var = "g:formatprg_args_".compoundtype
    let old_formatprg_args_expr_var = "g:formatprg_args_expr_".compoundtype
    if exists(old_formatprg_var) || exists(old_formatprg_args_var) || exists(old_formatprg_args_expr_var)
        echohl WarningMsg |
          \ echomsg "WARNING: the options g:formatprg_<filetype>, g:formatprg_args_<filetype> and g:formatprg_args_expr_<filetype> are no longer supported as of June 2015, due to major backward-incompatible improvements. Please check the README for help on how to configure your formatters." |
          \ echohl None
    endif

    " Detect configuration for all possible ftypes
    let b:formatters = []
    for supertype in ftypes
        let formatters_var = "g:formatters_".supertype
        if !exists(formatters_var)
            " No formatters defined
            if verbose
                echoerr "No formatters defined for supertype '".supertype
            endif
        else
            let formatters = eval(formatters_var)
            if type(formatters) != 3
                echoerr formatter_var." is not a list"
            else
                let b:formatters = b:formatters + formatters
            endif
        endif
    endfor

    if len(b:formatters) == 0
        " No formatters defined
        if verbose
            echoerr "No formatters defined for filetype '".ftype."'."
        endif
        return 0
    endif
    return 1
endfunction
