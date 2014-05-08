"some sensible stuff
set number "line numbering
set showcmd "show normal mode commands in the status bar
set splitright "create splits vertically to the right
set splitbelow

set scrolloff=999 "Center the screen when changing lines

set textwidth=100
set formatoptions-=t "prevent auto word wrapping

set cindent
set shiftwidth=4 "auto-indent amount

set expandtab
set tabstop=4

"Move the help split to the right
autocmd FileType help wincmd L

set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)
if &term == "screen" || &term == "screen-256color"
  set t_ts=k
  set t_fs=\
endif
set title
set ruler

"Make it more obvious which buffers are active
set fillchars+=stlnc:\

"Show tabs, trailing whitespace, and non-breaking spaces
set list listchars=tab:›\ ,extends:>,precedes:<,eol:¬
exec "set listchars+=trail:\uB7,nbsp:~"
set list

"Syntastic
let g:syntastic_java_javac_config_file_enabled=1

"vim-togglelist
let g:toggle_list_no_mappings=1
