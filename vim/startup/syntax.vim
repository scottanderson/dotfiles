"syntastic
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_disabled_filetypes=['html']
let g:syntastic_enable_signs=1
let g:syntastic_java_javac_options='-Xlint:-deprecation'

let g:syntastic_java_javac_custom_classpath_command = '~/dotfiles/scripts/syntastic-android-classpath.sh %FILE_PATH%'

"pydiction
let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'

"SyntaxRange
autocmd Syntax * call SyntaxRange#Include('@begin=python@', '@end=python@', 'python', 'NonText')
