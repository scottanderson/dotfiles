au BufNewFile,BufRead *.gradle set filetype=groovy
au BufRead,BufNewFile *.rc set filetype=sh

highlight OverLength ctermbg=magenta guibg=#592929
augroup vimrc_autocmds
  autocmd BufEnter * match OverLength /\%100v/
  autocmd BufEnter * set colorcolumn=100
  autocmd BufNewFile,BufRead COMMIT_EDITMSG match OverLength /\%72v/
  autocmd BufNewFile,BufRead COMMIT_EDITMSG set formatoptions+=t textwidth=72 colorcolumn=72 formatprg=par\ -w72
  autocmd BufNewFile,BufRead README match OverLength /\%72v/
  autocmd BufNewFile,BufRead README set formatoptions+=t textwidth=72 colorcolumn=72 formatprg=par\ -w72
augroup END
