call pathogen#infect()
filetype plugin indent on
syntax on

source ~/.vim/startup/color.vim
source ~/.vim/startup/environ.vim
source ~/.vim/startup/format.vim
source ~/.vim/startup/mapping.vim
source ~/.vim/startup/spell.vim

"Re-source vimrc
autocmd! BufWritePost ~/.vimrc,~/.vim/startup/*.vim source %

