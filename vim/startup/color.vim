"Powerline settings
set laststatus=2
let g:Powerline_symbols='fancy'

"skittles_berry config
if !has("gui_running")
    set term=screen-256color
endif
colo skittles_berry
set cursorline

set hlsearch
syntax on

highlight WhiteOnRed ctermfg=white ctermbg=red guibg=#ff0000 guifg=#ffffff
function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#'.@/
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 333) . 'm'
    call matchdelete(ring)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 333) . 'm'
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 333) . 'm'
    call matchdelete(ring)
    redraw
endfunction

