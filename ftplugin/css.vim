let &formatexpr="CSSBeautify()"
let s:bundleDir = fnamemodify(expand("<sfile>"), ":h:h:h")
let g:cssbeautify_file = fnameescape(s:bundleDir."/js-beautify/beautify-css.js")

let g:cssbeautify = {'indent_size': 4, 'indent_char': ' '}
set expandtab
set tabstop=4
set shiftwidth=4
