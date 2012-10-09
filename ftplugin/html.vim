let &formatexpr="HtmlBeautify()"
let s:bundleDir = fnamemodify(expand("<sfile>"), ":h:h:h")
let g:htmlbeautify_file = fnameescape(s:bundleDir."/js-beautify/beautify-html.js")

let g:htmlbeautify = {'indent_size': 2, 'indent_char': ' ', 'max_char': 78, 'brace_style': 'expand', 'unformatted': ['a', 'sub', 'sup', 'b', 'i', 'u']}
set expandtab
set tabstop=2
set shiftwidth=2
