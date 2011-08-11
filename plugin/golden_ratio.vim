let s:save_cpo = &cpo
set cpo&vim

if exists("g:loaded_golden_ratio")
  finish
endif
let g:loaded_golden_ratio = 1

function! s:GoldenRatioWidth()
  return (&columns / 1.618)
endfunction

function! s:GoldenRatioHeight()
  return (&lines / 1.618)
endfunction

function! s:ResizeToGoldenRatio()
  let l:ah = s:GoldenRatioHeight()
  let l:bh = (l:ah / 1.618)

  let l:aw = s:GoldenRatioWidth()
  let l:bw = (l:aw / 1.618)

  " Height has an special condition:
  " When there is only one window, or just windows
  " with a vertical split, the 'command window'
  " gets all the space for the shorter size of the
  " golden ratio (b), in order to avoid this, we just
  " check that the height of the (editor - current window)
  " is smaller than b. If thats the case, we just give the
  " window full height length.
  " check |help golden-ratio-intro|
  let l:currentHeight = winheight("%")
  if (&lines - l:currentHeight) < l:bh
    let l:height = "resize"
  else
    let l:height = printf("resize %f", l:ah)
  endif

  let l:width  = printf("vertical resize %f", l:aw)

  exec l:width
  exec l:height
endfunction

" Do plugin mappings
nnoremap <Plug>GoldenRatioResize :call <SID>ResizeToGoldenRatio()<CR>

if !hasmapto('<Plug>GoldenRatioResize') &&
      \ !hasmapto('<LEADER>g', 'n')
  nnoremap <unique> <LEADER>g <Plug>GoldenRationResize
endif

if !exists("g:golden_ratio_autocommand") || 
      \ (exists("g:golden_ratio_autocommand") &&
      \  g:golden_ratio_autocommands)

  au WinEnter,BufEnter * call <SID>ResizeToGoldenRatio()
endif

let &cpo = s:save_cpo
