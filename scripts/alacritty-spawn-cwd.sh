#!/bin/bash
# copied from: https://github.com/alacritty/alacritty/issues/808

# Spawn a new instance of Alacritty using the CWD of the currently focused
# Alacritty process.
#
# This is useful in environment like i3 where terminals are opened using a
# key-combination while another terminal is already focused.
#
# If the script is run with a non-Alacritty window in focus or a non-compliant
# version of Alacritty, an instance will be spawned in the user's $HOME.


#for alacritty
#termCmdXcwd="alacritty --working-directory "$(xcwd)""
#termCmdShellCwd="alacritty --working-directory \$SHELL_CWD"
#termWM_CLASS="Alacritty"

#for st
#termCmdXcwd="st -d "$(xcwd)" -e tmux"
#termCmdShellCwd="st -d \$SHELL_CWD -e tmux"
termCmdXcwd="st -d "$(xcwd)""
termCmdShellCwd="st -d \$SHELL_CWD"
termWM_CLASS="st"

#echo $(eval "echo $mycmd")

ACTIVE_WINDOW=$(xdotool getactivewindow)
ACTIVE_WM_CLASS=$(xprop -id $ACTIVE_WINDOW | grep WM_CLASS)
#if [[ $ACTIVE_WM_CLASS == *"Alacritty"* ]]

if [[ $ACTIVE_WM_CLASS == *"$termWM_CLASS"* ]]
then
    # Get PID. If _NET_WM_PID isn't set, bail.
    PID=$(xprop -id $ACTIVE_WINDOW | grep _NET_WM_PID | grep -oP "\d+")
    if [[ "$PID" == "" ]]
    then
        # actually, if you have xcwd installed you can just try it instead
        #alacritty --working-directory "$(xcwd)"
        $(eval "echo $termCmdXcwd")
    fi
    # Get first child of terminal
    CHILD_PID=$(pgrep -P $PID)
    if [[ "$PID" == "" ]]
    then
        # actually, if you have xcwd installed you can just try it instead
        #alacritty --working-directory "$(xcwd)"
        $(eval "echo $termCmdXcwd")
    fi
    # Get current directory of child. The first child should be the shell.
    pushd "/proc/${CHILD_PID}/cwd"
    SHELL_CWD=$(pwd -P)
    popd
    # Start alacritty with the working directory
    #alacritty --working-directory $SHELL_CWD
    $(eval "echo $termCmdShellCwd")
else
    # actually, if you have xcwd installed you can just try it instead
    #alacritty --working-directory "$(xcwd)"
    $(eval "echo $termCmdXcwd")
fi
