call pathogen#infect()
filetype plugin indent on
syntax on

"There are unicode characters in the startup files
"set encoding=utf-8
set tabpagemax=100

source ~/.vim/startup/color.vim
source ~/.vim/startup/environ.vim
source ~/.vim/startup/format.vim
source ~/.vim/startup/mapping.vim
source ~/.vim/startup/spell.vim
source ~/.vim/startup/syntax.vim

if has("gui_running")
    source ~/.vim/startup/gvim.vim
endif

"Re-source vimrc
autocmd! BufWritePost ~/.vimrc,~/.vim/startup/*.vim source %

