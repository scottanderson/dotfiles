git filter-branch --commit-filter "GIT_COMMITTER_EMAIL=\"$1\"; GIT_AUTHOR_EMAIL=\"$1\"; git commit-tree \"$@\";"
