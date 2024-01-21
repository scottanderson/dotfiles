-- Move the help split to the right
vim.cmd [[autocmd FileType help wincmd L]]

vim.cmd [[" vim -b : edit binary using xxd-format!]]
vim.cmd [[augroup Binary]]
vim.cmd [[  au!]]
vim.cmd [[  au BufReadPre   *.bin,*.sav let &bin=1]]
vim.cmd [[  au BufReadPost  *.bin,*.sav if &bin | %!xxd -g1]]
vim.cmd [[  au BufReadPost  *.bin,*.sav set ft=xxd | endif]]
vim.cmd [[  au BufWritePre  *.bin,*.sav if &bin | %!xxd -r]]
vim.cmd [[  au BufWritePre  *.bin,*.sav endif]]
vim.cmd [[  au BufWritePost *.bin,*.sav if &bin | %!xxd -g1]]
vim.cmd [[  au BufWritePost *.bin,*.sav set nomod | endif]]
vim.cmd [[augroup END]]
