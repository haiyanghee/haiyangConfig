#!/bin/bash
source /etc/bash.bashrc
echo 255 | sudo tee  /sys/class/backlight/amdgpu_bl0//brightness
sudo /home/haiyang/.scripts/keyboard.sh &
sudo /home/haiyang/.scripts/hdmi-thinkpad.sh &
