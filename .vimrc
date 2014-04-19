call pathogen#infect()
filetype plugin indent on
syntax on

source ~/.vim/startup/color.vim
source ~/.vim/startup/environ.vim
source ~/.vim/startup/format.vim
source ~/.vim/startup/mapping.vim

"Re-source vimrc
autocmd BufWritePost .vimrc,.vim/* source %

