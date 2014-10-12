if did_filetype()
    finish
endif
if getline(1) =~# '^#!/apollo/sbin/envroot "\$ENVROOT/bin/ruby"'
    setfiletype ruby
endif
