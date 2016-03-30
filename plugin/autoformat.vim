" Function for finding the formatters for this filetype
" Result is stored in b:formatters

if !exists('g:autoformat_autoindent')
    let g:autoformat_autoindent = 1
endif

function! s:find_formatters(...)
    " Detect verbosity
    let verbose = &verbose || g:autoformat_verbosemode == 1

    " Extract filetype to be used
    let ftype = a:0 ? a:1 : &filetype
    " Support composite filetypes by replacing dots with underscores
    let compoundtype = substitute(ftype, "[.]", "_", "g")
    if ftype =~? "[.]"
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
                echoerr "No formatters defined for supertype ".supertype
            endif
        else
            let formatters = eval(formatters_var)
            if type(formatters) != type([])
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
    " Detect verbosity
    let verbose = &verbose || g:autoformat_verbosemode == 1

    " Make sure formatters are defined and detected
    if !call('<SID>find_formatters', a:000)
        " No formatters defined
        if verbose
            echomsg "No format definitions are defined for this filetype."
        endif
        call s:Fallback()
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
        let b:formatprg = eval(eval(formatdef_var))

        " Detect if +python or +python3 is available, and call the corresponding function
        if !has("python") && !has("python3")
            echohl WarningMsg |
                \ echomsg "WARNING: vim has no support for python, but it is required to run the formatter!" |
                \ echohl None
            return 1
        endif
        if has("python3")
            let success = s:TryFormatterPython3()
        else
            let success = s:TryFormatterPython()
        endif
        if success
            if verbose
                echomsg "Definition in '".formatdef_var."' was successful."
            endif
            return 1
        else
            if verbose
                echomsg "Definition in '".formatdef_var."' was unsuccessful."
            endif
            let s:index = (s:index + 1) % len(b:formatters)
        endif

        if s:index == b:current_formatter_index
            if verbose
                echomsg "No format definitions were successful."
            endif
            " Tried all formatters, none worked
            call s:Fallback()
            return 0
        endif
    endwhile
endfunction

function! s:Fallback()
    " Detect verbosity
    let verbose = &verbose || g:autoformat_verbosemode == 1

    if exists('b:autoformat_remove_trailing_spaces') ? b:autoformat_remove_trailing_spaces == 1 : g:autoformat_remove_trailing_spaces == 1
        if verbose
            echomsg "Removing trailing whitespace..."
        endif
        call s:RemoveTrailingSpaces()
    endif

    if exists('b:autoformat_retab') ? b:autoformat_retab == 1 : g:autoformat_retab == 1
        if verbose
            echomsg "Retabbing..."
        endif
        retab
    endif

    if exists('b:autoformat_autoindent') ? b:autoformat_autoindent == 1 : g:autoformat_autoindent == 1
        if verbose
            echomsg "Autoindenting..."
        endif
        " Autoindent code
        exe "normal gg=G"
    endif

endfunction


" Call formatter
" If stderr is empty, apply result, return 1
" Otherwise, return 0

" +python version
function! s:TryFormatterPython()
    " Detect verbosity
    let verbose = &verbose || g:autoformat_verbosemode == 1

python << EOF
import vim, subprocess, os
from subprocess import Popen, PIPE
text = os.linesep.join(vim.current.buffer[:]) + os.linesep
formatprg = vim.eval('b:formatprg')
verbose = bool(int(vim.eval('verbose')))

env = os.environ.copy()
if int(vim.eval('exists("g:formatterpath")')):
    extra_path = vim.eval('g:formatterpath')
    env['PATH'] = ':'.join(extra_path) + ':' + env['PATH']

# When an entry is unicode, Popen can't deal with it in Python 2.
# As a pragmatic fix, we'll omit that entry.
env = {key : val for key, val in env.iteritems() if type(key) == type(val) == str}
p = subprocess.Popen(formatprg, env=env, shell=True, stdin=PIPE, stdout=PIPE, stderr=PIPE)
stdoutdata, stderrdata = p.communicate(text)

if stderrdata:
    if verbose:
        formattername = vim.eval('b:formatters[s:index]')
        print('Formatter {} has errors: {} Skipping.'.format(formattername, stderrdata))
        print('Failing config: {}'.format(repr(formatprg), stderrdata))
    vim.command('return 0')
else:
    # It is not certain what kind of line endings are being used by the format program.
    # Therefore we simply split on all possible eol characters.
    possible_eols = ['\r\n', os.linesep, '\r', '\n']

    # Often shell commands will append a newline at the end of their output.
    # It is not entirely clear when and why that happens.
    # However, extra newlines are almost never required, while there are linters that complain
    # about superfluous newlines, so we remove one empty newline at the end of the file.
    for eol in possible_eols:
        if len(stdoutdata) > 0 and stdoutdata[-1] == eol:
            stdoutdata = stdoutdata[:-1]

    lines = [stdoutdata]
    for eol in possible_eols:
        lines = [splitline for line in lines for splitline in line.split(eol)]

    vim.current.buffer[:] = lines
EOF

    return 1
endfunction

" +python3 version
function! s:TryFormatterPython3()
    " Detect verbosity
    let verbose = &verbose || g:autoformat_verbosemode == 1

python3 << EOF
import vim, subprocess, os
from subprocess import Popen, PIPE

text = bytes(os.linesep.join(vim.current.buffer[:]) + os.linesep, 'utf-8')
formatprg = vim.eval('b:formatprg')
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
        print('Formatter {} has errors: {} Skipping.'.format(formattername, stderrdata))
        print('Failing config: {}'.format(repr(formatprg), stderrdata))
    vim.command('return 0')
else:
    # It is not certain what kind of line endings are being used by the format program.
    # Therefore we simply split on all possible eol characters.
    possible_eols = ['\r\n', os.linesep, '\r', '\n']

    stdoutdata = stdoutdata.decode('utf-8')

    # Often shell commands will append a newline at the end of their output.
    # It is not entirely clear when and why that happens.
    # However, extra newlines are almost never required, while there are linters that complain
    # about superfluous newlines, so we remove one empty newline at the end of the file.
    for eol in possible_eols:
        if len(stdoutdata) > 0 and stdoutdata[-1] == eol:
            stdoutdata = stdoutdata[:-1]

    lines = [stdoutdata]
    for eol in possible_eols:
        lines = [splitline for line in lines for splitline in line.split(eol)]

    vim.current.buffer[:] = lines
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
    echomsg 'Selected formatter: '.b:formatters[b:current_formatter_index]
endfunction

function! s:PreviousFormatter()
    call s:find_formatters()
    if !exists('b:current_formatter_index')
        let b:current_formatter_index = 0
    endif
    let l = len(b:formatters)
    let b:current_formatter_index = (b:current_formatter_index - 1 + l) % l
    echomsg 'Selected formatter: '.b:formatters[b:current_formatter_index]
endfunction

function! s:CurrentFormatter()
    call s:find_formatters()
    if !exists('b:current_formatter_index')
        let b:current_formatter_index = 0
    endif
    echomsg 'Selected formatter: '.b:formatters[b:current_formatter_index]
endfunction

" Create commands for iterating through formatter list
command! NextFormatter call s:NextFormatter()
command! PreviousFormatter call s:PreviousFormatter()
command! CurrentFormatter call s:CurrentFormatter()

" Other commands
function! s:RemoveTrailingSpaces()
    let user_gdefault = &gdefault
    try
        set nogdefault
        silent! %s/\s\+$
    finally
        let &gdefault = user_gdefault
    endtry
endfunction
command! RemoveTrailingSpaces call s:RemoveTrailingSpaces()
