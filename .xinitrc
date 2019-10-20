#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


exec fcitx &
xset m 3/2 0
amixer -c 0 set Speaker 100%
amixer -c 0 set Speaker unmute
amixer -c 0 set Headphone 98%
amixer -c 0 set Headphone unmute

#sudo ~/.scripts/startup.sh &
sudo ~/.scripts/keyboard.sh &
#~/.scripts/lockscreen.sh &
~/dwm-haiyang/dwm-bar/dwm_bar.sh &

#exec i3
exec dwm
