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

"Some senseless stuff
set modeline

let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

"Powerline
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

"Move the help split to the right
autocmd FileType help wincmd L

set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)
if &term == "screen" || &term == "screen-256color"
  set t_ts=k
  set t_fs=\
endif
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

"mark occurrences
hi GreenBackground  term=reverse ctermbg=22 guibg=#455354
nnoremap z/ :if !AutoHighlightToggle()<Bar>match none<Bar>endif<CR>
function! AutoHighlightToggle()
  if s:hilightmark >= 1
    hi link MarkOccurence NONE
    setl updatetime=4000
    echo 'Highlight current word: off'
    let s:hilightmark = 0
  else
    au CursorHold * exe printf('match MarkOccurence /\V\<%s\>/', escape(expand('<cword>'), '/\'))
    hi link MarkOccurence GreenBackground
    setl updatetime=500
    if s:hilightmark == 0
      echo 'Highlight current word: ON'
    endif
    let s:hilightmark = 1
  endif
endfunction
"let s:hilightmark = -1
"call AutoHighlightToggle()
let s:hilightmark = 0

"CtrlP
let g:ctrlp_by_filename=1 "By default, match only filename, not path (Ctrl-D to toggle)
let g:ctrlp_match_window='top,order:ttb'
let g:ctrlp_switch_buffer='et' "Don't open new windows if the buffer is already active
let g:ctrlp_working_path_mode='ra' "Use git repository as the working directory
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*/bin/*.class
let g:ctrlp_open_new_file='v' "Open new files in vertical splits
