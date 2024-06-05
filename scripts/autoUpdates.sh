#!/bin/bash
#took ideas from https://bbs.archlinux.org/viewtopic.php?id=247428
#NOTE: running this in user level's crontab doesn't work (sudo can't get password) even if you get rid of the password restriction in visudo
#however, running it in root's crontabe and invoking the script via `su - user -c "script"` works ... not too sure why

#notify-send need XDG_RUNTIME_DIR for $DBUS_SESSION_BUS_ADDRESS ... but all I needed was to set XDG_RUNTIME_DIR
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export DISPLAY=":0" 
echo "$(id)"

#askDmenuAndExitOnReject() takes in 2 parameters, which is the string we want to ask for in dmenu, and string we print if user rejects the request (something not "yes" or "y" case insensitively)
function askDmenuAndExitOnReject(){
    notify-send "Auto update Demnu prompt!"
    #query=$(printf "no\nyes" | dmenu -i -p "$1" | awk '{print tolower($0)}')
    query=$(printf "no\nyes" | dmenu -i -p "$1") #add -i to dmenu so no need to convert response to lower case
    echo "answer to '$1' is: '$query'"
    pkill notify-osd #clear the notify popup
    if [[ ! ( $query == "yes" || $query == "y" ) ]] ; then
        notify-send "$2"; 
        exit 1;
    fi
}

#NOTE that user id of root is always 0, as hard coded in the linux kerne.. see https://superuser.com/questions/626843/does-the-root-account-always-have-uid-gid-0
#although its harder to set up root with notify-send, so I won't do it..
#uid=$(id -u)
##exit if root is not running this script
#[ $uid -ne 0 ] && { echo "Only root should run this script '$0'!"; exit 1; }

#create folder to store these logs
outDir="/home/haiyang/.local/autoUpdates"
outFile="pacmanAutoUpdate$(date +"%Y-%m-%d-%H:%M").log"
outPath="$outDir/$outFile"
mkdir -p "$outDir"
badUg="Aborting upgrade ... log at $outDir"

askDmenuAndExitOnReject "Auto updates will be starting! Will output to $outPath. Start syncing packages?"   "Package database syncing rejected! Will not update system now"

if ! script -ae -c 'sudo specialPacman.sh -Sy' "$outPath" ; then notify-send -u critical -t 0 "Package database syncing failed! $badUg"; exit 1; fi
#if ! echo "111" ; then notify-send -u critical -t 0 "Package database syncing failed! $badUg"; exit 1; fi

#first update archlinux-keyring
askDmenuAndExitOnReject "Install archlinux-keyring first?"   "Rejected to install archlinux-keyring! Will not update system now"
if ! script -ae -c "sudo specialPacman.sh -S --noconfirm archlinux-keyring" "$outPath" ; then notify-send -u critical -t 0 "Failed to update archlinux-keyring! $badUg"; exit 1; fi
#if ! echo "222" ; then notify-send -u critical -t 0 "Package database syncing failed! $badUg"; exit 1; fi

#then update everything else
askDmenuAndExitOnReject "Install everything else?"   "Rejected to install everything else! Will not update system now"
if ! script -ae -c "sudo specialPacman.sh -Su --noconfirm" "$outPath" ; then notify-send -u critical -t 0 "Failed to update everything else! $badUg"; exit 1; fi
#if ! echo "333" ; then notify-send -u critical -t 0 "Package database syncing failed! $badUg"; exit 1; fi

#then ask if we want to reboot
notify-send "Auto update Demnu prompt!"
query=$(printf "none\npoweroff\nreboot" | dmenu -i -p "Update finished! Poweroff or Reboot?")
echo "answer to 'Update finished! Poweroff or Reboot?' is: '$query'"
pkill notify-osd #clear the notify popup
if [[ $query == "poweroff" ]] ; then poweroff #echo "would have powerd off!"
elif [[ $query == "reboot" ]] ; then reboot #echo "would have reboot!"
else 
    notify-send "Rejected to reboot and poweroff, which is totally fine! Please reboot when you have time"; 
    exit 1;
fi
