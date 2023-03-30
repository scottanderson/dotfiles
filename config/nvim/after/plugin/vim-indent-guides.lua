vim.cmd [[let g:indent_guides_auto_colors = 0]]
vim.cmd [[autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#262626 ctermbg=235 ctermfg=240]]
vim.cmd [[autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#303030 ctermbg=236 ctermfg=240]]
vim.cmd [[autocmd BufNewFile,BufRead * IndentGuidesEnable]]
