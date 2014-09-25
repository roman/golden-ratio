let s:save_cpo = &cpo
set cpo&vim

if exists("g:loaded_golden_ratio")
  finish
endif
let g:loaded_golden_ratio = 1

if !exists("g:golden_ratio_autocommand")
  let s:gr_auto = 1
else
  let s:gr_auto = g:golden_ratio_autocommand
  unlet g:golden_ratio_autocommand
endif

if !exists('g:golden_ratio_wrap_ignored')
  let g:golden_ratio_wrap_ignored = 0
endif

if !exists('g:golden_ratio_exclude_nonmodifiable')
  let g:golden_ratio_exclude_nonmodifiable = 0
endif

function! s:golden_ratio_width()
  return &columns / 1.618
endfunction

function! s:golden_ratio_height()
  return &lines / 1.618
endfunction

function! s:window_list()
  let wl = range(1, winnr('$'))
  if g:golden_ratio_exclude_nonmodifiable
    let wl = filter(wl, 'getwinvar(v:val, "&modifiable")')
  endif
  return wl
endfunction

function! s:find_parallel_windows(current_window)
  return {
         \ 'width' : filter(reverse(s:window_list()),
           \ 'winheight(v:val) == winheight(a:current_window) ' .
           \ '&& v:val != a:current_window'),
         \ 'height': filter(reverse(s:window_list()),
           \ 'winwidth(v:val) == winwidth(a:current_window) ' .
           \ '&& v:val != a:current_window')
        \}
endfunction

function! s:resize_ignored_window(windows, ignored_width, ignored_height)
  if !exists('b:golden_ratio_saved_wrap')
    let b:golden_ratio_saved_wrap = &wrap
  endif

  let &l:wrap = g:golden_ratio_wrap_ignored

  if len(a:windows.width) > 0 && index(a:windows.width, winnr()) >= 0
    let l:width_size = a:ignored_width / len(a:windows.width)
    exec printf("vertical resize %f", l:width_size)
  endif

  if len(a:windows.height) > 0 && index(a:windows.height, winnr()) >= 0
    let l:current_height = winheight(winnr())
    " This is when you are having a vertical setup
    if &lines - l:current_height < a:ignored_height
      exec "resize"
    else
      let l:height_size = a:ignored_height / len(a:windows.height)
      exec printf("resize %f", l:height_size)
    endif
  endif

endfunction

function! s:resize_ignored_windows(windows, ignored_width, ignored_height)
  let l:current_window = winnr()
  let b:golden_ratio_resizing_ignored = 1
  for window in range(1, winnr('$'))
    exec window . "wincmd w"
    call s:resize_ignored_window(a:windows, a:ignored_width, a:ignored_height)
  endfor
  exec l:current_window . "wincmd w"
  let b:golden_ratio_resizing_ignored = 0
endfunction

function! s:resize_main_window(window,
      \ main_width, main_height,
      \ ignored_width, ignored_height)
  if exists('b:golden_ratio_saved_wrap')
    " restore previously saved state
    let &l:wrap = b:golden_ratio_saved_wrap
  endif

  " Height has an special condition:
  " When there is only one window, or just windows
  " with a vertical split, the 'command window'
  " gets all the space for the shorter size of the
  " golden ratio (b), in order to avoid this, we just
  " check that the height of the (editor - current window)
  " is smaller than b. If thats the case, we just give the
  " window full height length.
  " check |help golden-ratio-intro|
  let l:current_height = winheight(a:window)
  if &lines - l:current_height < a:ignored_height
    let l:height = "resize"
  else
    let l:height = printf("resize %f", a:main_height)
  endif
  let l:width  = printf("vertical resize %f", a:main_width)

  exec l:width
  exec l:height
endfunction

function! s:resize_to_golden_ratio()
  if exists("b:golden_ratio_resizing_ignored") &&
        \ b:golden_ratio_resizing_ignored
    return
  endif

  if g:golden_ratio_exclude_nonmodifiable && !&modifiable
    return
  endif

  let l:ah = s:golden_ratio_height()
  let l:bh = l:ah / 1.618

  let l:aw = s:golden_ratio_width()
  let l:bw = l:aw / 1.618

  let l:parallel_windows = s:find_parallel_windows(winnr())
  call s:resize_ignored_windows(l:parallel_windows, l:bw, l:bh)
  call s:resize_main_window(winnr(), l:aw, l:ah, l:bw, l:bh)
endfunction

function! s:toggle_global_golden_ratio()
  if s:gr_auto
    let s:gr_auto = 0
    au! GoldenRatioAug
  else
    let s:gr_auto = 1
    call <SID>initiate_golden_ratio()
    call <SID>resize_to_golden_ratio()
  endif
endfunction

function! s:initiate_golden_ratio()
  if s:gr_auto
    aug GoldenRatioAug
      au!
      au WinEnter,BufEnter * call <SID>resize_to_golden_ratio()
      au BufLeave * let b:golden_ratio_saved_wrap = &wrap
    aug END
  endif
endfunction

" Do plugin mappings

nnoremap <Plug>(golden_ratio_resize) :<C-u>call <SID>resize_to_golden_ratio()<CR>
inoremap <Plug>(golden_ratio_resize) <Esc>:call <SID>resize_to_golden_ratio()<CR>a
nnoremap <Plug>(golden_ratio_toggle) :<C-u>call <SID>toggle_global_golden_ratio()<CR>
inoremap <Plug>(golden_ratio_toggle) <Esc>:call <SID>toggle_global_golden_ratio()<CR>a

command! GoldenRatioResize call <SID>resize_to_golden_ratio()
command! GoldenRatioToggle call <SID>toggle_global_golden_ratio()

cabbrev grresize GoldenRatioResize
cabbrev grtoggle GoldenRatioToggle

call <SID>initiate_golden_ratio()

let &cpo = s:save_cpo

" vim:et:ts=2:sw=2:sts=2
