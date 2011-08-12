let s:save_cpo = &cpo
set cpo&vim

if exists("g:loaded_golden_ratio")
  finish
endif
let g:loaded_golden_ratio = 1

function! s:golden_ratio_width()
  return &columns / 1.618
endfunction

function! s:golden_ratio_height()
  return &lines / 1.618
endfunction

function! s:resize_to_golden_ratio()
  let l:ah = s:golden_ratio_height()
  let l:bh = l:ah / 1.618

  let l:aw = s:golden_ratio_width()
  let l:bw = l:aw / 1.618

  " Height has an special condition:
  " When there is only one window, or just windows
  " with a vertical split, the 'command window'
  " gets all the space for the shorter size of the
  " golden ratio (b), in order to avoid this, we just
  " check that the height of the (editor - current window)
  " is smaller than b. If thats the case, we just give the
  " window full height length.
  " check |help golden-ratio-intro|
  let l:current_height = winheight("%")
  if &lines - l:current_height < l:bh
    let l:height = "resize"
  else
    let l:height = printf("resize %f", l:ah)
  endif

  let l:width  = printf("vertical resize %f", l:aw)

  exec l:width
  exec l:height
endfunction

" Do plugin mappings

if !hasmapto('<Plug>(golden_ratio_resize)') &&
      \ !mapcheck('<LEADER>g', 'n')

  nmap <silent> <LEADER>g <Plug>(golden_ratio_resize)
endif

nnoremap <Plug>(golden_ratio_resize) :<C-u>call <SID>resize_to_golden_ratio()<CR>
inoremap <Plug>(golden_ratio_resize) <Esc>:call <SID>resize_to_golden_ratio()<CR>a

if !exists("g:golden_ratio_autocommand") ||
      \ (exists("g:golden_ratio_autocommand") &&
      \  g:golden_ratio_autocommand)

  au WinEnter,BufEnter * call <SID>resize_to_golden_ratio()
endif

let &cpo = s:save_cpo
