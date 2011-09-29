#!/bin/sh

# Make `git diffall` to open all files at once. Useful is you use Beyond Compare or other
# tool that support tabbed interface
#
# http://stackoverflow.com/questions/1220309/git-difftool-open-all-diff-files-immediately-not-in-serial

for name in $(git diff --name-only $1); do git difftool $1 $name & done