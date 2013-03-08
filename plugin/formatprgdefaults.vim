let g:formatprg_cs = "astyle"
let g:formatprg_args_cs = "--mode=cs --style=ansi -p -P -c"
let g:formatprg_c = "astyle"
let g:formatprg_args_c = "--mode=c --style=ansi -p -P -c"
let g:formatprg_cpp = "astyle"
let g:formatprg_args_cpp = "--mode=c --style=ansi -p -P -c"
let g:formatprg_java = "astyle"
let g:formatprg_args_java = "--mode=java --style=ansi -p -P -c"
let g:formatprg_php = "phpCB"
let g:formatprg_args_php = "--space-after-if --space-after-switch --space-after-while --space-before-start-angle-bracket --space-after-end-angle-bracket --one-true-brace-function-declaration --glue-amperscore --change-shell-comment-to-double-slashes-comment --force-large-php-code-tag --force-true-false-null-contant-lowercase --align-equal-statements --comment-rendering-style PEAR --equal-align-position 50 --padding-char-count 4"
let g:formatprg_python = "autopep8"
let g:formatprg_args_python = "/dev/stdin"
let g:formatprg_xml = "tidy"
let g:formatprg_args_xml = "-q -xml --show-errors 10 --show-warnings 10 --indent auto --indent-spaces 4 --vertical-space yes --tidy-mark no --wrap 68"
let g:formatprg_html = "tidy"
let g:formatprg_args_html = "-q --show-errors 0 --show-warnings 0 --indent auto --indent-spaces 4 --vertical-space yes --tidy-mark no --wrap 68"
let g:formatprg_javascript = "js-beautify"
let g:formatprg_args_javascript = "-i"

"We allow an alternative path for js-beautify
"If js-beautify is installed as a bundle, we still want to detect it
let s:bundleDir = fnamemodify(expand("<sfile>"), ":h:h:h")
let s:jsbeautify_alternative = s:bundleDir."/js-beautify/python/".g:formatprg_javascript
if executable(s:jsbeautify_alternative)
	let g:formatprg_javascript = s:jsbeautify_alternative
endif
