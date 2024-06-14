# if shell is not interactive, return
test "$-" == "${-%*i*}" && echo "The shell is not interactive in $HOME/.profile! We won't source the bashrc" && return

if test -f "$HOME/.bashrc" ; then . "$HOME/.bashrc" ; fi
