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

source ~/.bashrc

#set cursor
xsetroot -cursor_name left_ptr

exec fcitx &
export GTK_IM_MODULE=fcitx

sxhkd &

xset m 3/2 0
amixer -c 0 set Speaker 100%
amixer -c 0 set Speaker unmute
#amixer -c 0 set Headphone 98%
#amixer -c 0 set Headphone unmute

#~/.scripts/lockscreen.sh &
#sudo ~/.scripts/disable-usb-trigger-wakeup.sh &
sudo ~/.scripts/mouse.sh &
sudo ~/.scripts/keyboard.sh &

sudo ~/.scripts/hdmi-thinkpad.sh &
sudo ~/.scripts/connectToWifi.sh &
dwmblocks &
feh --bg-max $wallpaper
# compton is replaced by picom now
#compton &
picom -CG&
~/.scripts/normalScreenSaverTimeout.sh &
~/.scripts/redshiftopen.sh &


#exec i3
exec dwm
#exec xmonad
