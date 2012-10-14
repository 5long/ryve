if exists("g:loaded_ryve") || &cp
  finish
endif
let g:loaded_ryve = 1

function! s:SearchByMotion(type, ...)
  let saved_unnamed_reg = @@
  silent normal! `[v`]y
  let search_term = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @/ = search_term
  let @@ = saved_unnamed_reg
endfunction

function! s:ReplaceByMotion(type, ...)
  silent normal! `[v`]p
endfunction

function! s:ReplaceByMotionLine(type, ...)
  silent normal! Vp
endfunction

function! s:PasteByMotion(type, ...)
  let saved_unnamed_reg = @@
  call s:ReplaceByMotion(a:type)
  let @@ = saved_unnamed_reg
endfunction

function! s:PasteByMotionLine(type, ...)
  let saved_unnamed_reg = @@
  call s:ReplaceByMotionLine(a:type)
  let @@ = saved_unnamed_reg
endfunction

function! s:GoToName()
  let pos = s:GoToPossibleAssignOp()
  if pos == -1
    return
  endif
  normal! B
endfunction

function! s:GoToValue()
  let pos = s:GoToPossibleAssignOp()
  if pos == -1
    return
  endif
  normal! lW
endfunction

function! s:GoToPossibleAssignOp()
  let [l, c, offset] = getpos(".")[1:3]
  let cur_line = getline(".")
  let pos = match(cur_line, '\V=', c)
  if pos == -1
    let pos = match(cur_line, '\V=', 0)
  endif

  if pos == -1
    return -1
  endif

  call cursor(l, pos, offset)
  return pos
endfunction

nnoremap <silent> <Plug>SearchByMotion :<c-u>set opfunc=<SID>SearchByMotion<CR>g@
nnoremap <silent> <Plug>ReplaceByMotion :<c-u>set opfunc=<SID>ReplaceByMotion<CR>g@
nnoremap <silent> <Plug>ReplaceByMotionLine :<c-u>set opfunc=<SID>ReplaceByMotionLine<CR>g@
nnoremap <silent> <Plug>PasteByMotion :<c-u>set opfunc=<SID>PasteByMotion<CR>g@
nnoremap <silent> <Plug>PasteByMotionLine :<c-u>set opfunc=<SID>PasteByMotionLine<CR>g@
nnoremap <silent> <Plug>GoToName :<c-u>call <SID>GoToName()<CR>
nnoremap <silent> <Plug>GoToValue :<c-u>call <SID>GoToValue()<CR>

if !hasmapto('<Plug>SearchByMotion', 'n')
  nmap <unique> g/ <Plug>SearchByMotion
endif

if !hasmapto('<Plug>ReplaceByMotion', 'n')
  nmap <unique> gr <Plug>ReplaceByMotion
  nmap <unique> grr <Plug>ReplaceByMotionLine
endif

if !hasmapto('<Plug>PasteByMotion', 'n')
  nmap gp <Plug>PasteByMotion
  nmap gpp <Plug>PasteByMotionLine
endif

if !hasmapto('<Plug>GoToName', 'n')
  nmap gh <Plug>GoToName
endif

if !hasmapto('<Plug>GoToValue', 'n')
  nmap gl <Plug>GoToValue
endif
