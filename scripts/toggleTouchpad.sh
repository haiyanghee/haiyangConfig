#!/bin/sh
#copied this script from https://github.com/lahwaacz/Scripts/blob/master/toggle-touchpad.sh
# Toggle touchpad status
# Using libinput and xinput

# Use xinput list and do a search for touchpads. Then get the first one and get its name.
#device="$(xinput list | grep -P '(?<= )[\w\s:]*(?i)(touchpad|synaptics)(?-i).*?(?=\s*id)' -o | head -n1)"
device=$(echo "$(xinput list | grep Touchpad)" | sed "s/.*↳\s*//; s/Touchpad.*/Touchpad/")

# If it was activated disable it and if it wasn't disable it
[[ "$(xinput list-props "$device" | grep -P ".*Device Enabled.*\K.(?=$)" -o)" == "1" ]] &&
    xinput disable "$device" ||
    xinput enable "$device"