let s:save_cpo = &cpo
set cpo&vim

if exists("g:loaded_golden_ratio")
  finish
endif
echom "Loading Golden Ratio"
let g:loaded_golden_ratio = 1

function! s:GoldenRatioWidth()
  return (&columns / 1.618)
endfunction

function! s:GoldenRatioHeight()
  return (&lines / 1.618)
endfunction

function! s:ResizeToGoldenRatio()
  let l:height = printf("resize %f", s:GoldenRatioHeight())
  let l:width  = printf("vertical resize %f", s:GoldenRatioWidth())

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
