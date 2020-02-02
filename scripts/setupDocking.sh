#!/bin/bash
source /etc/bash.bashrc
echo 255 | sudo tee  /sys/class/backlight/amdgpu_bl0//brightness
sudo ~/.scripts/keyboard.sh &
sudo ~/.scripts/hdmi-thinkpad.sh &
