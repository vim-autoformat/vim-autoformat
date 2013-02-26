let g:formatprg_cs = "astyle --mode=cs --style=ansi"
let g:formatprg_c = "astyle --mode=c --style=ansi"
let g:formatprg_cpp = "astyle --mode=c --style=ansi"
let g:formatprg_java = "astyle --mode=java --style=ansi"
let g:formatprg_php = "phpCB --space-after-if --space-after-switch --space-after-while --space-before-start-angle-bracket --space-after-end-angle-bracket --one-true-brace-function-declaration --glue-amperscore --change-shell-comment-to-double-slashes-comment --force-large-php-code-tag --force-true-false-null-contant-lowercase --align-equal-statements --comment-rendering-style PEAR --equal-align-position 50 --padding-char-count 4"
let g:formatprg_python = "autopep8 /dev/stdin"
let g:formatprg_xml = "tidy -q -xml --show-errors 10 --show-warnings 10 --indent auto --indent-spaces 2 --vertical-space yes --tidy-mark no --wrap 68"
let g:formatprg_html = "tidy -q --show-errors 0 --show-warnings 0 --indent auto --indent-spaces 2 --vertical-space yes --tidy-mark no --wrap 68"


let g:formatprg_javascript = "js-beautify -i"
let s:bundleDir = fnamemodify(expand("<sfile>"), ":h:h:h")
let s:prgpath   = s:bundleDir."/js-beautify/python/".s:prgname
if executable(s:prgpath)
	"If js-beautify is installed as a bundle
	let g:formatprg_javascript = s:bundleDir."/js-beautify/python/".g:formatprg_javascript
endif
