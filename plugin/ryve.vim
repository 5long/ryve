function! SearchAMotion(type, ...)
  silent exec 'normal! `[v`]y'
  let @/ = @"
  call search(@")
endfunction

function! ReplaceMotion(type, ...)
  let l:str_to_lay = @"
  silent exec 'normal! `[v`]d'
  let l:deleted = @"
  let @" = l:str_to_lay
  silent exec 'normal! P'
  let @" = l:deleted
endfunction

nnoremap g/ :set opfunc=SearchAMotion<CR>g@
nnoremap gr :set opfunc=ReplaceMotion<CR>g@
