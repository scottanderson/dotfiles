au BufRead,BufNewFile *.rc set filetype=sh

highlight OverLength ctermbg=magenta guibg=#592929
augroup vimrc_autocmds
  autocmd BufEnter * match OverLength /\%100v/
  autocmd BufNewFile,BufRead COMMIT_EDITMSG match OverLength /\%72v/
  autocmd BufNewFile,BufRead COMMIT_EDITMSG set textwidth=72
  autocmd BufNewFile,BufRead COMMIT_EDITMSG set formatoptions+=t
  autocmd BufNewFile,BufRead README match OverLength /\%72v/
  autocmd BufNewFile,BufRead READNE set textwidth=72
  autocmd BufNewFile,BufRead README set formatoptions+=t
augroup END
