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


# make xmobar to read the pipe ...
# https://tlatsas.github.io/2013/11/03/reading-from-named-pipes-in-xmobar/
volume_pipe=/tmp/.volume-pipe
if [[ ! -e $volume_pipe ]]; then
    mkfifo $_volume_pipe
fi
~/.config/xmobar/scripts/xmobar_alsa.sh &


#set cursor
xsetroot -cursor_name left_ptr
#turns on numlock
numlockx &

# Note: should put these in ~/.pam_environment
#export GTK_IM_MODULE=fcitx
#export QT_IM_MODULE=fcitx
#export XMODIFIERS=@im=fcitx
#exec fcitx &
exec fcitx5 &

#applet for network manager
#exec nm-applet &

sxhkd &
#udiskie --tray& #automatically mount usb! very cool

#start imwheel
#imwheel -f -b 45&

#fix/patch for libinput for mouse scrolling: https://github.com/tkkcc/libinput_patch
#echo 2 > /tmp/libinput_discrete_deltay_multiplier

xset m 3/2 0
#amixer -c 0 set Speaker 100%
#amixer -c 0 set Speaker unmute
#amixer -c 0 set Headphone 98%
#amixer -c 0 set Headphone unmute

#~/.scripts/lockscreen.sh &
#sudo ~/.scripts/disable-usb-trigger-wakeup.sh &
#sudo ~/.scripts/mouse.sh &
sudo ~/.scripts/keyboard.sh &

sudo ~/.scripts/connectToWifi.sh &

sudo ~/.scripts/hdmi-thinkpad.sh &

feh --bg-max $wallpaper &
# compton is replaced by picom now
#picom -CG&
#use experimental-backend for transparent-clipping
#picom --experimental-backend -CG&
~/.scripts/normalScreenSaverTimeout.sh &
~/.scripts/redshiftopen.sh &

#nohup easyeffects --gapplication-service


#exec i3

#bluetooth 
blueman-applet&

dwmblocks &
exec dwm

#exec ~/.scripts/startDwm.sh
#exec xmonad
