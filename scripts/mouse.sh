#!/bin/bash
sleep 5
sudo modprobe -r psmouse
sudo modprobe psmouse
#disable touchpad
xinput disable "ETPS/2 Elantech Touchpad"
