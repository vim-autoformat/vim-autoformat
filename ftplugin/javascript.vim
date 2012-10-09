let &formatexpr="JsBeautify()"
let s:bundleDir = fnamemodify(expand("<sfile>"), ":h:h:h")
let g:jsbeautify_file = fnameescape(s:bundleDir."/js-beautify/beautify.js")

let g:jsbeautify = {'indent_size': 4, 'indent_char': ' '}
set expandtab
set tabstop=4
set shiftwidth=4
