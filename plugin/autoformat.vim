"Set the format programs for the right filetypes
au filetype javascript let &formatexpr="JsBeautify()"
au filetype html let &formatexpr="HtmlBeautify()"
au filetype css let &formatexpr="CSSBeautify()"
au filetype php let &formatprg="phpCB --space-after-if   --space-after-switch --space-after-while --space-before-start-angle-bracket   --space-after-end-angle-bracket   --one-true-brace-function-declaration   --glue-amperscore   --change-shell-comment-to-double-slashes-comment   --force-large-php-code-tag   --force-true-false-null-contant-lowercase   --align-equal-statements   --comment-rendering-style PEAR   --equal-align-position 50   --padding-char-count 4"

"Function for formatting the entire buffer
function g:WebideAutoformat()
  	"Save window state
  	let winview=winsaveview()
	"Autoformat code
	:silent exe "normal gggqG"
	"Recall window state
  	call winrestview(winview)
endfunction

