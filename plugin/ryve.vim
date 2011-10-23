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
  let l:replacement = @"
  silent exec 'normal! `[v`]d'
  let l:replaced = @"
  let @" = l:replacement
  silent exec 'normal! P'
  let @" = l:replaced
endfunction

nnoremap <silent> g/ :set opfunc=<SID>SearchAMotion<CR>g@
nnoremap <silent> gr :set opfunc=<SID>ReplaceMotion<CR>g@
