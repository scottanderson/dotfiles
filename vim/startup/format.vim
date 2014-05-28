au BufRead,BufNewFile *.rc set filetype=sh

highlight OverLength ctermbg=magenta guibg=#592929
augroup vimrc_autocmds
  autocmd BufEnter * match OverLength /\%100v/
  autocmd BufNewFile,BufRead COMMIT_EDITMSG match OverLength /\%72v/
  autocmd BufNewFile,BufRead COMMIT_EDITMSG set textwidth=72 formatoptions+=t formatprg=par\ -w72
  autocmd BufNewFile,BufRead README match OverLength /\%72v/
  autocmd BufNewFile,BufRead README set textwidth=72 formatoptions+=t formatprg=par\ -w72
augroup END
