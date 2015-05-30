" Function for finding the formatters for this filetype
" Result is stored in b:formatters
function! s:find_formatters(...)
    " Detect verbosity
    let verbose = &verbose || exists("g:autoformat_verbosemode")

    " Extract filetype to be used
    let type = a:0 ? a:1 : &filetype
    " Support composite filetypes by replacing dots with underscores
    let type = substitute(type, "[.]", "_", "g")

    let formatters_var = "g:formatters_".type
    let b:formatters = []

    if !exists(formatters_var)
        " No formatters defined
        if verbose
            echoerr "No formatters defined for filetype '".type."'."
        endif
        return 0
    endif

    let formatters = eval(formatters_var)
    if len(formatters) == 0
        " No formatters defined
        if verbose
            echoerr "No formatters defined for filetype '".type."'."
        endif
        return 0
    endif

    let b:formatters = formatters
    return 1
endfunction


" Try all formatters, starting with the currently selected one, until one
" works. If none works, autoindent the buffer.
function! s:TryAllFormatters(...) range
    "echom a:firstline.", ".a:lastline
    "echom line('.')", ".line('v')
    "echom line("'<")", ".line("'>")
    "echom mode()

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
        if s:TryFormatter()
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
function! s:TryFormatter()
    " Detect verbosity
    let verbose = &verbose || exists("g:autoformat_verbosemode")

    " Save window state
    let winview=winsaveview()

python << EOF
import vim, subprocess
from subprocess import Popen, PIPE
text = '\n'.join(vim.current.buffer[:])
formatprg = vim.eval('&formatprg')
verbose = vim.eval('verbose')
p = subprocess.Popen(formatprg, shell=True, stdin=PIPE, stdout=PIPE, stderr=PIPE)
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

    " Recall window state
    call winrestview(winview)

    return 1
endfunction


" Create a command for formatting the entire buffer
command! -nargs=? -range=% -complete=filetype Autoformat <line1>,<line2>call s:TryAllFormatters(<f-args>)


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
