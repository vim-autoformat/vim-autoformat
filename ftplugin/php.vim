"Set the formatter name and arguments for this filetype
let s:prgname="phpCB"
let s:arguments="--space-after-if --space-after-switch --space-after-while --space-before-start-angle-bracket --space-after-end-angle-bracket --one-true-brace-function-declaration --glue-amperscore --change-shell-comment-to-double-slashes-comment --force-large-php-code-tag --force-true-false-null-contant-lowercase --align-equal-statements --comment-rendering-style PEAR --equal-align-position 50 --padding-char-count 4"

"Set the formatprg option, if the formatter is installed
"globally or in the formatters folder
call g:FindFormatter(s:prgname, s:arguments)
