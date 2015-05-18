" Function for finding the formatters for this filetype
function! s:find_formatters(...)
    " Detect verbosity
    let s:verbose = &verbose || exists("g:autoformat_verbosemode")


    " Extract filetype to be used
    let type = a:0 ? a:1 : &filetype
    " Support composite filetypes by replacing dots with underscores
    let type = substitute(type, "[.]", "_", "g")


    let s:formatters_var = "g:formatters_".type
    let b:formatters = []

    if !exists(s:formatters_var)
        " No formatters defined
        if s:verbose
            echoerr "No formatters defined for filetype '".type."'."
        endif
        return 0
    endif

    let s:formatters = eval(s:formatters_var)
    if len(s:formatters) == 0
        " No formatters defined
        if s:verbose
            echoerr "No formatters defined for filetype '".type."'."
        endif
        return 0
    endif

    let b:formatters = s:formatters
    return 1
endfunction


" Function for finding and setting the currently selected formatter
function! s:set_formatter(...)
    " Detect verbosity
    let s:verbose = &verbose || exists("g:autoformat_verbosemode")


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


    let &formatprg = eval(s:formatters[b:current_formatter_index])
    return 1
endfunction



" Function for formatting the entire buffer
function! s:Autoformat(...)
    " Save window state
    let winview=winsaveview()

    if call('<SID>set_formatter', a:000)
        " Autoformat code

python << EOF
import vim, subprocess
from subprocess import Popen, PIPE
text = '\n'.join(vim.current.buffer[:])
formatprg = vim.eval('&formatprg')
p = subprocess.Popen(formatprg, shell=True, stdin=PIPE, stdout=PIPE, stderr=PIPE)
stdoutdata, stderrdata = p.communicate(text)
if stderrdata:
    vim.command('echoerr "Error communicating with formatter: {}"'.format(stderrdata))
else:
    vim.current.buffer[:] = stdoutdata.split('\n')
EOF

    else
        " Autoindent code
        exe "normal gg=G"
    endif

    " Recall window state
    call winrestview(winview)
endfunction

" Create a command for formatting the entire buffer
command! -nargs=? -complete=filetype Autoformat call s:Autoformat(<f-args>)


" Functions for iterating through list of available formatters
function! s:NextFormatter()
    call s:find_formatters()
    if !exists('b:current_formatter_index')
        let b:current_formatter_index = 0
    endif
    let b:current_formatter_index = (b:current_formatter_index + 1) % len(b:formatters)
endfunction

function! s:PreviousFormatter()
    call s:find_formatters()
    if !exists('b:current_formatter_index')
        let b:current_formatter_index = 0
    endif
    let s:l = len(b:formatters)
    let b:current_formatter_index = (b:current_formatter_index - 1 + s:l) % s:l
endfunction

" Create commands for iterating through formatter list
command! NextFormatter call s:NextFormatter()
command! PreviousFormatter call s:PreviousFormatter()
