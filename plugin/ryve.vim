if exists("g:loaded_ryve") || &cp
    finish
endif
let g:loaded_ryve = 1

function! s:SearchAMotion(type, ...)
  silent exec 'normal! `[v`]y'
  let @/ = @"
  call search(@")
endfunction

function! s:ReplaceMotion(type, ...)
  let l:str_to_lay = @"
  silent exec 'normal! `[v`]d'
  let l:deleted = @"
  let @" = l:str_to_lay
  silent exec 'normal! P'
  let @" = l:deleted
endfunction

nnoremap g/ :set opfunc=<SID>SearchAMotion<CR>g@
nnoremap gr :set opfunc=<SID>ReplaceMotion<CR>g@
