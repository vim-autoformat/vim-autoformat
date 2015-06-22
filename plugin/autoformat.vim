" Function for finding the formatters for this filetype
" Result is stored in b:formatters
function! s:find_formatters(...)
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


" Try all formatters, starting with the currently selected one, until one
" works. If none works, autoindent the buffer.
function! s:TryAllFormatters(...) range
    " Make sure formatters are defined and detected
    if !call('<SID>find_formatters', a:000)
        return 0
    endif

    " Make sure index exist and is valid
    if !exists('b:current_formatter_index')
        let b:current_formatter_index = 0
    endif
    if b:current_formatter_index >= len(b:formatters)
        let b:current_formatter_index = 0
    endif

    " Try all formatters, starting with selected one
    let s:index = b:current_formatter_index

    while 1
        let formatdef_var = 'g:formatdef_'.b:formatters[s:index]
        " Formatter definition must be existent
        if !exists(formatdef_var)
            echoerr "No format definition found in '".formatdef_var."'."
            return 0
        endif

        " Eval twice, once for getting definition content,
        " once for getting the final expression
        let &formatprg = eval(eval(formatdef_var))

        " Detect if +python or +python3 is available, and call the corresponding function
        if !has("python") && !has("python3")
            echohl WarningMsg |
                \ echomsg "WARNING: vim has no support for python, but it is required to run the formatter!" |
                \ echohl None
            return 1
        endif
        if has("python")
            let success = s:TryFormatterPython()
        else
            let success = s:TryFormatterPython3()
        endif
        if success
            return 1
        else
            let s:index = (s:index + 1) % len(b:formatters)
        endif

        if s:index == b:current_formatter_index
            " Tried all formatters, none worked
            return 0
        endif
    endwhile


    " Autoindent code if no formatters work
    exe "normal gg=G"

endfunction


" Call formatter
" If stderr is empty, apply result, return 1
" Otherwise, return 0

" +python version
function! s:TryFormatterPython()
    " Detect verbosity
    let verbose = &verbose || exists("g:autoformat_verbosemode")

python << EOF
import vim, subprocess, os
from subprocess import Popen, PIPE

text = '\n'.join(vim.current.buffer[:])
formatprg = vim.eval('&formatprg')
verbose = bool(int(vim.eval('verbose')))
env = os.environ.copy()
if int(vim.eval('exists("g:formatterpath")')):
    extra_path = vim.eval('g:formatterpath')
    env['PATH'] = ':'.join(extra_path) + ':' + env['PATH']

p = subprocess.Popen(formatprg, env=env, shell=True, stdin=PIPE, stdout=PIPE, stderr=PIPE)
stdoutdata, stderrdata = p.communicate(text)
if stderrdata:
    if verbose:
        formattername = vim.eval('b:formatters[s:index]')
        print('Formatter {} has errors: {}. Skipping.'.format(formattername, stderrdata))
        print('Failing config: {} '.format(repr(formatprg), stderrdata))
    vim.command('return 0')
else:
    vim.current.buffer[:] = stdoutdata.split('\n')
EOF

    return 1
endfunction

" +python3 version
function! s:TryFormatterPython3()
    " Detect verbosity
    let verbose = &verbose || exists("g:autoformat_verbosemode")

python3 << EOF
import vim, subprocess, os
from subprocess import Popen, PIPE

#text = '\n'.join(vim.current.buffer[:])
text = bytes('\n'.join(vim.current.buffer[:]), 'utf-8')
formatprg = vim.eval('&formatprg')
verbose = bool(int(vim.eval('verbose')))
env = os.environ.copy()
if int(vim.eval('exists("g:formatterpath")')):
    extra_path = vim.eval('g:formatterpath')
    env['PATH'] = ':'.join(extra_path) + ':' + env['PATH']

p = subprocess.Popen(formatprg, env=env, shell=True, stdin=PIPE, stdout=PIPE, stderr=PIPE)
stdoutdata, stderrdata = p.communicate(text)
if stderrdata:
    if verbose:
        formattername = vim.eval('b:formatters[s:index]')
        print('Formatter {} has errors: {}. Skipping.'.format(formattername, stderrdata))
        print('Failing config: {} '.format(repr(formatprg), stderrdata))
    vim.command('return 0')
else:
    #vim.current.buffer[:] = stdoutdata.split('\n')
    vim.current.buffer[:] = stdoutdata.split(b'\n')
EOF

    return 1
endfunction


" Create a command for formatting the entire buffer
" Save and recall window state to prevent vim from jumping to line 1
command! -nargs=? -range=% -complete=filetype Autoformat let winview=winsaveview()|<line1>,<line2>call s:TryAllFormatters(<f-args>)|call winrestview(winview)


" Functions for iterating through list of available formatters
function! s:NextFormatter()
    call s:find_formatters()
    if !exists('b:current_formatter_index')
        let b:current_formatter_index = 0
    endif
    let b:current_formatter_index = (b:current_formatter_index + 1) % len(b:formatters)
    echom 'Selected formatter: '.b:formatters[b:current_formatter_index]
endfunction

function! s:PreviousFormatter()
    call s:find_formatters()
    if !exists('b:current_formatter_index')
        let b:current_formatter_index = 0
    endif
    let l = len(b:formatters)
    let b:current_formatter_index = (b:current_formatter_index - 1 + l) % l
    echom 'Selected formatter: '.b:formatters[b:current_formatter_index]
endfunction

" Create commands for iterating through formatter list
command! NextFormatter call s:NextFormatter()
command! PreviousFormatter call s:PreviousFormatter()
