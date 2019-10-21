#!/bin/bash
/bin/bash /home/haiyang/.scripts/mouse.sh
#setting the keyboard rate
xset r rate 320 23
#sudo xset b off
#sudo xset b 0 0 0
xset b off
xset b 0 0 0
#setting the caps lock button as escape
sudo setxkbmap -option caps:escape
sudo modprobe psmouse
#disable the stupid right click button on keyboard
xmodmap -e "keycode 135 = VoidSymbol"
