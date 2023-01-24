#!/bin/bash
#xsetwacom set 13 MapToOutput HDMI-A-0
#xsetwacom set 14 MapToOutput HDMI-A-0
#xsetwacom set 23 MapToOutput HDMI-A-0
#xsetwacom set 24 MapToOutput HDMI-A-0

SCREEN="HDMI-A-0"

tabletnum=$(xsetwacom list | grep -iw stylus |grep -wo "[0-9]*")

xsetwacom set "$tabletnum" MapToOutput "$SCREEN"


#some keys, for example, the "Add" or "Plus" key, is a modifier for xsetwacom, so you cant just type "key ctrl +"..
#can find the corresponding key in /usr/include/X11/keysymdef.h as the manual stated.

xsetwacom set "HUION Huion Tablet Pad pad" Button 1 "key ctrl z" 
xsetwacom set "HUION Huion Tablet Pad pad" Button 2 "key shift ctrl E" #easer tool
xsetwacom set "HUION Huion Tablet Pad pad" Button 3 "key shift ctrl P" #pen tool
xsetwacom set "HUION Huion Tablet Pad pad" Button 8 "key ctrl +0xffab " #zoom in
xsetwacom set "HUION Huion Tablet Pad pad" Button 9 "key ctrl +0xffad " #zoom out
xsetwacom set "HUION Huion Tablet Pad pad" Button 10 "key shift ctrl H " #highlighter
xsetwacom set "HUION Huion Tablet Pad pad" Button 11 "key shift ctrl G " #region selection
xsetwacom set "HUION Huion Tablet Pad pad" Button 12 "key shift ctrl A " #hand tool
