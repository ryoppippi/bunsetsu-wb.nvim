function! bunsetsu_wb#bunsetsu() abort
  echo bunsetsu#tokenize(getline('.'), &l:iskeyword)
endfunction

