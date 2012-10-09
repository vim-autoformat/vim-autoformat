"Function for formatting the entire buffer
function! g:Autoformat()
  	"Save window state
  	let winview=winsaveview()
	"Autoformat code
	:silent exe "normal gggqG"
	"Recall window state
  	call winrestview(winview)
endfunction
