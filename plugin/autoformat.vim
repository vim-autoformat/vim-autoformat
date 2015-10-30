if exists('g:loaded_autoformat')
  finish
endif
let g:loaded_autoformat = 1

" Setup formatexpr for buffers through FileType event.
augroup autoformat
    au!
    autocmd FileType * set formatexpr=autoformat#formatexpr()
augroup END

" Create a command for formatting the entire buffer
" Save and recall window state to prevent vim from jumping to line 1
command! -nargs=? -range=% -complete=filetype Autoformat let winview=winsaveview()|<line1>,<line2>call autoformat#TryAllFormatters(<f-args>)|call winrestview(winview)


" Functions for iterating through list of available formatters
function! s:NextFormatter()
    call autoformat#find_formatters()
    if !exists('b:current_formatter_index')
        let b:current_formatter_index = 0
    endif
    let b:current_formatter_index = (b:current_formatter_index + 1) % len(b:formatters)
    echom 'Selected formatter: '.b:formatters[b:current_formatter_index]
endfunction

function! s:PreviousFormatter()
    call autoformat#find_formatters()
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
