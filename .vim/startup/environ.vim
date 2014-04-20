"some sensible stuff
set number "line numbering
set showcmd "show normal mode commands in the status bar
set splitright "create splits vertically to the right
set splitbelow

set scrolloff=999 "Center the screen when changing lines

"Move the help split to the right
autocmd FileType help wincmd L

set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)
if &term == "screen" || &term == "screen-256color"
  set t_ts=k
  set t_fs=\
endif
set title
set ruler

