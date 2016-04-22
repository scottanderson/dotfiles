au BufNewFile,BufRead *.gradle set filetype=groovy
au BufRead,BufNewFile *.rc set filetype=sh

highlight OverLength ctermbg=magenta guibg=#592929
augroup vimrc_autocmds
  autocmd BufEnter                    *              match OverLength /\%100v/
  autocmd BufEnter,BufNewFile,BufRead COMMIT_EDITMSG match OverLength /\%72v/
  autocmd BufEnter,BufNewFile,BufRead COMMIT_EDITMSG set formatoptions+=t textwidth=72 formatprg=par\ -w72
  autocmd BufEnter,BufNewFile,BufRead README         match OverLength /\%72v/
  autocmd BufEnter,BufNewFile,BufRead README         set formatoptions+=t textwidth=72 formatprg=par\ -w72
augroup END
