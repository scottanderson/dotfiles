"some sensible stuff
set number "line numbering
set showcmd "show normal mode commands inthe status bar
set splitright "create splits verticall to the right
set splitbelow

"Center the screen when changing lines
set so=999 "scrolloff

"Move the help split to the right
autocmd FileType help wincmd L

set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)
if &term == "screen"
  set t_ts=k
  set t_fs=\
endif
set notitle
set ruler

