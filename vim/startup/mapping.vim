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

"Map ctrl+hjkl to pgup/dn, home/end
no <C-h> 0
no <C-j> <C-d>
no <C-k> <C-u>
no <C-l> $

"Insert mode movement
ino <C-h> <Left>
ino <C-j> <Down>
ino <C-k> <Up>
ino <C-l> <Right>

" Rewire n and N to blink when highlighing
nnoremap <silent> n   n:call HLNext(0.2)<cr>
nnoremap <silent> N   N:call HLNext(0.2)<cr>

"Ctrl+n/p to jump through the buffers
nmap <C-p> :bp<cr>
nmap <C-n> :bn<cr>

"Toggle spell checking
nmap <silent> <leader>s :set spell!<cr>

"CtrlP
nmap <leader>t :CtrlP<cr>
