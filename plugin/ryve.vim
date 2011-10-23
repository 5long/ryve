if exists("g:loaded_ryve") || &cp
    finish
endif
let g:loaded_ryve = 1

function! s:SearchByMotion(type, ...)
  silent exec 'normal! `[v`]y'
  let @/ = @"
  call search(@")
endfunction

function! s:ReplaceByMotion(type, ...)
  let l:replacement = @"
  silent exec 'normal! `[v`]d'
  let l:replaced = @"
  let @" = l:replacement
  silent exec 'normal! P'
  let @" = l:replaced
endfunction

nnoremap <silent> <Plug>SearchByMotion :set opfunc=<SID>SearchByMotion<CR>g@
nnoremap <silent> <Plug>ReplaceByMotion :set opfunc=<SID>ReplaceByMotion<CR>g@

nmap g/ <Plug>SearchByMotion
nmap gr <Plug>ReplaceByMotion
