"Disable the arrow keys in normal, insert, and visual mode, to force learning hjkl
no <Left>  <Nop>
no <Right> <Nop>
no <silent> <Up>    :move .-2<cr>
no <silent> <Down>  :move .1<cr>
ino <Left>  <Nop>
ino <Right> <Nop>
ino <Up>    <Nop>
ino <Down>  <Nop>
vno <Left>  <Nop>
vno <Right> <Nop>
vno <Up>    <Nop>
vno <Down>  <Nop>

" Rewire n and N to blink when highlighing
nnoremap <silent> n   n:call HLNext(0.2)<cr>
nnoremap <silent> N   N:call HLNext(0.2)<cr>
