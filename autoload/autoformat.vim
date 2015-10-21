function! autoformat#formatexpr()
  " Use internal method for single lines / autoformatting.
  if v:count == 1
    return 1
  endif
  " let winview=winsaveview()
  exe v:lnum.";+".(v:count-1).' call TryAllFormatters()'
  " call winrestview(winview)
  return 0
endfunction
