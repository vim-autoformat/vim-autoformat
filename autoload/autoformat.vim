function! autoformat#formatexpr()
  exe v:lnum.";+".(v:count-1).' call TryAllFormatters()'
endfunction
